defmodule FileType.CFB do
  import FileType.Utils, only: [sigil_h: 2]

  @clsid_offset 80
  @clsid_bytes 16

  @header [{30, 2}, {48, 4}]

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

  @spec detect(IO.device()) :: FileType.Magic.result()
  def detect(io) do
    with {:ok, fields} <- :file.pread(io, @header),
         {:ok, header} <- parse_header(fields),
         {:ok, clsid} <- read_clsid(io, header) do
      match(clsid)
    else
      :eof -> {:error, :unrecognized}
      {:error, reason} -> {:error, reason}
    end
  end

  for {clsid, type} <- @types do
    defp match(unquote(clsid)), do: {:ok, unquote(type)}
  end

  defp match(_), do: {:ok, @cfb}

  defp read_clsid(io, header) do
    root_offset = header.sector_size * (header.root_index + 1)
    :file.pread(io, root_offset + @clsid_offset, @clsid_bytes)
  end

  defp parse_header([<<exp::little-16>>, <<index::little-32>>]) do
    {:ok, %{sector_size: round(:math.pow(2, exp)), root_index: index}}
  end

  defp parse_header(_), do: {:error, :unrecognized}
end
