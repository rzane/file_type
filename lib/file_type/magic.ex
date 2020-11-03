defmodule FileType.Magic do
  @moduledoc false

  alias FileType.Magic.Matcher
  alias FileType.Magic.Reader

  @type ext :: binary()
  @type mime :: binary()
  @type type :: {ext(), mime()} | module()
  @type magic :: [binary() | non_neg_integer()]
  @type t :: {type(), magic()}
  @type size :: non_neg_integer()
  @type location :: {non_neg_integer(), size()}
  @type result :: {:ok, {binary(), binary()}} | {:error, FileType.error()}

  @size 40

  def detect(io) do
    with {:error, :unrecognized} <- Matcher.detect(io, @size) do
      Reader.detect(io, @size)
    end
  end

  @doc """
  Get the number of bytes that would be required to match the entry.
  """
  @spec size_of(magic()) :: size()
  def size_of(magic), do: size_of(magic, 0)
  defp size_of([], acc), do: acc
  defp size_of([h | t], acc) when is_integer(h), do: size_of(t, acc + h)
  defp size_of([h | t], acc), do: size_of(t, acc + byte_size(h))

  @doc """
  Convert our magic signature to something we can pass to `:file.pread`.
  """
  @spec location_of(magic()) :: [location()]
  def location_of(magic) do
    location_of(magic, 0, [])
  end

  defp location_of([], _, acc), do: acc

  defp location_of([h | t], offset, acc) when is_integer(h) do
    location_of(t, offset + h, acc)
  end

  defp location_of([h | t], offset, acc) when is_binary(h) do
    size = byte_size(h)
    location_of(t, offset + size, acc ++ [{offset, size}])
  end
end
