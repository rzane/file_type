defmodule FileType.CFB do
  @cfb {"cfb", "application/x-cfb"}

  @sector_size_location 30
  @root_index_location 48
  @clsid_offset 80
  @clsid_bytes 16

  def postprocess(io, @cfb) do
    with {:ok, sector_size} <- read_sector_size(io),
         {:ok, root_index} <- read_root_index(io),
         {:ok, clsid} <- read_clsid(io, sector_size, root_index) do
      match(clsid)
    else
      :eof -> {:error, :unrecognized}
    end
  end

  def postprocess(_io, type), do: {:ok, type}

  defp match(_) do
    {:ok, @cfb}
  end

  defp read_clsid(io, sector_size, index) do
    :file.pread(io, sector_size * (index + 1) + @clsid_offset, @clsid_bytes)
  end

  defp read_root_index(io) do
    with {:ok, <<index::little-size(32)>>} <- :file.pread(io, @root_index_location, 4) do
      {:ok, index}
    end
  end

  defp read_sector_size(io) do
    with {:ok, <<exp::little-size(16)>>} <- :file.pread(io, @sector_size_location, 2) do
      {:ok, round(:math.pow(2, exp))}
    end
  end
end
