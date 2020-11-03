defmodule FileType.Magic.Reader do
  @moduledoc false

  alias FileType.Magic

  @spec detect(IO.device(), [Magic.t()]) :: Magic.result()
  def detect(io, entries) do
    locations = Enum.flat_map(entries, & &1.locations)

    with {:ok, data} <- :file.pread(io, locations),
         {:ok, type} when is_atom(type) <- match(data, entries),
         do: type.detect(io)
  end

  defp match([], []), do: {:error, :unrecognized}

  defp match(data, [%Magic{type: type, sequence: sequence} | entries]) do
    fields = Enum.reject(sequence, &is_integer/1)

    if List.starts_with?(data, fields) do
      {:ok, type}
    else
      data
      |> Enum.drop(length(fields))
      |> match(entries)
    end
  end
end
