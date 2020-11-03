defmodule FileType.Fallback do
  @moduledoc false

  import FileType.Utils

  @fallbacks [
    {{"s3m", "audio/x-s3m"}, [{44, "SCRM"}]},
    {{"mobi", "application/x-mobipocket-ebook"}, [{60, ~h"424f4f4b4d4f4249"}]},
    {{"dcm", "application/dicom"}, [{128, ~h"4449434d"}]},
    {{"tar", "application/x-tar"}, [{257, "ustar"}]},
    {{"mts", "video/mp2t"}, [{4, "G"}, {196, "G"}]}
  ]

  @locations for {_, sequence} <- @fallbacks,
                 {n, bytes} <- sequence,
                 do: {n, byte_size(bytes)}

  @matches for {type, locations} <- @fallbacks,
               do: {type, Enum.map(locations, &elem(&1, 1))}

  @spec detect(IO.device()) :: FileType.Magic.result()
  def detect(io) do
    with {:ok, data} <- :file.pread(io, @locations) do
      match(data, @matches)
    end
  end

  def match([], []) do
    {:error, :unknown}
  end

  def match(data, [{type, magic} | matches]) do
    if List.starts_with?(data, magic) do
      {:ok, type}
    else
      data
      |> Enum.drop(length(magic))
      |> match(matches)
    end
  end
end
