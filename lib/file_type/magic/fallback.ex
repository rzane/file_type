defmodule FileType.Magic.Fallback do
  @moduledoc false

  alias FileType.Magic
  alias FileType.Magic.Registration

  @type entry :: Registration.t()
  @type location :: {non_neg_integer(), non_neg_integer()}

  @spec detect(IO.device(), [entry()]) :: Magic.result()
  def detect(io, entries) do
    locations = Enum.flat_map(entries, &locate(elem(&1, 1)))

    with {:ok, data} <- :file.pread(io, locations),
         {:ok, type} when is_atom(type) <- match(data, entries),
         do: type.detect(io)
  end

  defp match([], []) do
    {:error, :unknown}
  end

  defp match(data, [{type, magic} | entries]) do
    fields = Enum.reject(magic, &is_integer/1)

    if List.starts_with?(data, fields) do
      {:ok, type}
    else
      data
      |> Enum.drop(length(fields))
      |> match(entries)
    end
  end

  @doc """
  Determine which strategy we should employ for each entry.
  """
  @spec split([entry()], non_neg_integer()) :: {[entry()], [entry()]}
  def split(entries, size) do
    Enum.split_with(entries, fn {_, magic} ->
      sizeof(magic) <= size
    end)
  end

  @doc """
  Get the total required byte size of the magic.
  """
  @spec sizeof(Registration.magic()) :: non_neg_integer()
  def sizeof(magic), do: sizeof(magic, 0)
  defp sizeof([], acc), do: acc
  defp sizeof([h | t], acc) when is_integer(h), do: sizeof(t, acc + h)
  defp sizeof([h | t], acc), do: sizeof(t, acc + byte_size(h))

  @doc """
  Convert our magic signature to something we can pass to `:file.pread`.
  """
  @spec locate(Registration.magic()) :: [location()]
  def locate(magic) do
    locate(magic, 0, [])
  end

  defp locate([], _, acc), do: acc

  defp locate([h | t], offset, acc) when is_integer(h) do
    locate(t, offset + h, acc)
  end

  defp locate([h | t], offset, acc) when is_binary(h) do
    size = byte_size(h)
    locate(t, offset + size, acc ++ [{offset, size}])
  end
end
