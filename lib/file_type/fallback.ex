defmodule FileType.Fallback do
  @moduledoc false

  @type location :: {non_neg_integer(), non_neg_integer()}

  @spec detect(IO.device(), [Registration.t()]) :: FileType.Magic.result()
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
  Convert our magic signature to something we can pass to `:file.pread`.
  """
  @spec locate(Registration.magic()) :: [location()]
  def locate(magic) do
    locate(magic, 0, [])
  end

  defp locate([], _, acc), do: acc

  defp locate([part | parts], offset, acc) when is_integer(part) do
    locate(parts, offset + part, acc)
  end

  defp locate([part | parts], offset, acc) when is_binary(part) do
    size = byte_size(part)
    locate(parts, offset + size, acc ++ [{offset, size}])
  end
end
