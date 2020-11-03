defmodule FileType.Magic do
  @moduledoc false

  alias FileType.Magic.Matcher
  alias FileType.Magic.Reader
  alias FileType.Magic.Database

  @type ext :: binary()
  @type mime :: binary()
  @type type :: {ext(), mime()} | module()
  @type sequence :: [binary() | non_neg_integer()]
  @type size :: non_neg_integer()
  @type location :: {non_neg_integer(), size()}
  @type result :: {:ok, {binary(), binary()}} | {:error, FileType.error()}
  @type t :: %__MODULE__{
          type: type(),
          size: size(),
          sequence: sequence(),
          locations: [location()]
        }

  @size 40

  @enforce_keys [:type, :size, :sequence, :locations]
  defstruct [:type, :size, :sequence, :locations]

  @doc """
  Build a new magic and calculate computed fields.
  """
  @spec new(type(), sequence()) :: t()
  def new(type, sequence) when is_list(sequence) do
    %__MODULE__{
      type: type,
      sequence: sequence,
      size: get_size(sequence),
      locations: get_locations(sequence)
    }
  end

  @doc """
  Detect the file based on the magic database.
  """
  @spec detect(IO.device()) :: result()
  def detect(io) do
    with {:error, :unrecognized} <- Matcher.detect(io, @size) do
      Reader.detect(io, read_entries(@size))
    end
  end

  defp read_entries(size) do
    for entry <- Database.entries(), entry.size > size, do: entry
  end

  @spec get_size(sequence()) :: size()
  def get_size(sequence), do: get_size(sequence, 0)
  defp get_size([], acc), do: acc
  defp get_size([h | t], acc) when is_integer(h), do: get_size(t, acc + h)
  defp get_size([h | t], acc), do: get_size(t, acc + byte_size(h))

  @spec get_locations(sequence()) :: [location()]
  def get_locations(sequence), do: get_locations(sequence, 0, [])
  defp get_locations([], _, acc), do: acc

  defp get_locations([h | t], offset, acc) when is_integer(h) do
    get_locations(t, offset + h, acc)
  end

  defp get_locations([h | t], offset, acc) when is_binary(h) do
    size = byte_size(h)
    get_locations(t, offset + size, acc ++ [{offset, size}])
  end
end
