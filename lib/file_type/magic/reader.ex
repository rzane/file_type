defmodule FileType.Magic.Reader do
  @moduledoc false

  alias FileType.Magic
  alias FileType.Magic.Database

  @spec detect(IO.device(), Magic.size()) :: Magic.result()
  def detect(io, size) do
    entries = find_entries(size)
    locations = find_locations(entries)

    with {:ok, data} <- :file.pread(io, locations),
         {:ok, type} when is_atom(type) <- match(data, entries),
         do: type.detect(io)
  end

  defp find_entries(size) do
    Enum.filter(Database.entries(), fn {_, magic} ->
      Magic.size_of(magic) > size
    end)
  end

  defp find_locations(entries) do
    Enum.flat_map(entries, fn {_type, magic} ->
      Magic.location_of(magic)
    end)
  end

  defp match([], []), do: {:error, :unrecognized}

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
end
