defmodule FileType.CFB do
  import FileType.Utils, only: [sigil_h: 2]

  @sector_size_location 30
  @root_index_location 48
  @clsid_offset 80
  @clsid_bytes 16

  @cfb {"cfb", "application/x-cfb"}
  @word {"doc", "application/msword"}
  @xls {"xls", "application/vnd.ms-excel"}
  @ppt {"ppt", "application/vnd.ms-powerpoint"}
  @msi {"msi", "application/x-msdownload"}

  @types %{
    ~h"1008020000000000c000000000000046" => @xls,
    ~h"2008020000000000c000000000000046" => @xls,
    ~h"0609020000000000c000000000000046" => @word,
    ~h"108d81649b4fcf1186ea00aa00b929e8" => @ppt,
    ~h"84100c0000000000c000000000000046" => @msi
  }

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

  for {clsid, type} <- @types do
    defp match(unquote(clsid)), do: {:ok, unquote(type)}
  end

  defp match(_), do: {:ok, @cfb}

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
