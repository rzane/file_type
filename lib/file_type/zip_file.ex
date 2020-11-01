defmodule FileType.ZipFile do
  @moduledoc false

  @eocd_size 22
  @eocd_sig <<0x50, 0x4B, 0x05, 0x06>>

  @header_size 46
  @header_sig <<0x50, 0x4B, 0x01, 0x02>>

  @zip {"zip", "application/zip"}

  @mimetypes [
    {"epub", "application/epub+zip"},
    {"odt", "application/vnd.oasis.opendocument.text"},
    {"ods", "application/vnd.oasis.opendocument.spreadsheet"},
    {"odp", "application/vnd.oasis.opendocument.presentation"}
  ]

  defmodule Header do
    defstruct [:name, :size]
  end

  def postprocess(@zip, io), do: detect(io)
  def postprocess(type, _io), do: type

  def detect(io) do
    case list_headers(io) do
      {:ok, headers} ->
        Enum.find_value(headers, &detect_header/1)

      {:error, _reason} ->
        nil
    end
  end

  defp detect_header(%Header{name: "META-INF/mozilla.rsa"}) do
    {"xpi", "application/x-xpinstall"}
  end

  for {ext, mime} <- @mimetypes, size = byte_size(mime) do
    defp detect_header(%Header{name: "mimetype", size: unquote(size)}) do
      {unquote(ext), unquote(mime)}
    end
  end

  defp detect_header(_), do: @zip

  defp list_headers(io) do
    with {:ok, start} <- find_eocd(io, {:eof, -@eocd_size}) do
      list_headers(io, start, [])
    end
  end

  defp list_headers(io, offset, headers) do
    case read_header(io, offset) do
      {:ok, header} -> list_headers(io, :cur, headers ++ [header])
      {:error, reason} -> {:error, reason}
      :eof -> {:ok, headers}
    end
  end

  defp find_eocd(io, location) do
    case :file.pread(io, location, @eocd_size) do
      {:ok, <<@eocd_sig, _::binary-size(12), start::little-size(32), _::binary-size(2)>>} ->
        {:ok, start}

      {:ok, data} when byte_size(data) == @eocd_size ->
        find_eocd(io, {:cur, -1})

      {:ok, _} ->
        {:error, :invalid}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp read_header(io, location) do
    with {:ok, data} <- :file.pread(io, location, @header_size) do
      parse_header(io, data)
    end
  end

  defp parse_header(
         io,
         <<@header_sig, _::binary-size(20), size::little-size(32), name_length::little-size(16),
           extra_length::little-size(16), comment_length::little-size(16), _::binary-size(12)>>
       ) do
    case :file.read(io, name_length + extra_length + comment_length) do
      {:ok, <<name::binary-size(name_length)>> <> _} ->
        {:ok, %Header{name: name, size: size}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_header(_io, <<@eocd_sig>> <> _), do: :eof
  defp parse_header(_io, _data), do: {:error, :invalid}
end
