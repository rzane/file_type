defmodule FileType do
  @required_bytes 300

  @type reason :: File.posix() | :badarg | :terminated | :unrecognized

  defmacrop sigil_h({:<<>>, _, [data]}, []) do
    Base.decode16!(data, case: :lower)
  end

  defmacrop magic(data, offset \\ 0) do
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacrop ftyp(data) do
    quote do: <<_::binary-size(4), "ftyp", unquote(data)>> <> _
  end

  @doc """
  Determine the MIME type of a file on disk.

  ## Examples

      iex> FileType.from_path("file.png")
      {:ok, "image/png"}

      iex> FileType.from_path("file.abc")
      {:error, :unrecognized}

      iex> FileType.from_path("does-not-exist.txt")
      {:error, :enoexist}

  """
  @spec from_path(binary) :: {:ok, binary} | {:error, reason}
  def from_path(path) when is_binary(path) do
    with {:ok, file} <- :file.open(path, [:read, :binary]),
         {:ok, data} <- :file.read(file, @required_bytes),
         :ok <- :file.close(file) do
      case match(data) do
        nil -> {:error, :unrecognized}
        mime -> {:ok, mime}
      end
    end
  end

  @spec match(binary) :: binary | nil
  defp match(ftyp("MSNV")), do: "video/mp4"
  defp match(ftyp("M4V")), do: "video/mp4"
  defp match(ftyp("isom")), do: "video/mp4"
  defp match(ftyp("f4v ")), do: "video/mp4"
  defp match(ftyp("mp42")), do: "video/mp4"
  defp match(ftyp("qt")), do: "video/quicktime"
  defp match(magic("free", 4)), do: "video/quicktime"
  defp match(magic("mdat", 4)), do: "video/quicktime"
  defp match(magic("moov", 4)), do: "video/quicktime"
  defp match(magic("wide", 4)), do: "video/quicktime"
  defp match(magic(~h"1a45dfa3")), do: "video/x-matroska"

  defp match(magic("ID3")), do: "audio/mpeg"
  defp match(magic("WAV", 8)), do: "audio/x-wav"

  defp match(magic("BM")), do: "image/bmp"
  defp match(magic("RIFF")), do: "image/webp"
  defp match(ftyp("heic")), do: "image/heic"
  defp match(ftyp("heix")), do: "image/heic"
  defp match(ftyp("mif1")), do: "image/heic"
  defp match(magic(~h"89504e47")), do: "image/png"
  defp match(magic(~h"ffd8ff")), do: "image/jpeg"
  defp match(magic(~h"474946")), do: "image/gif"
  defp match(magic(~h"49492a00")), do: "image/tiff"
  defp match(magic(~h"4d4d002a")), do: "image/tiff"

  defp match(magic(~h"1f8b")), do: "application/gzip"
  defp match(magic(~h"504b0304")), do: "application/zip"
  defp match(magic("Rar!")), do: "application/vnd.rar"
  defp match(magic(~h"757374617200", 257)), do: "application/x-tar"
  defp match(magic(~h"7573746172202000", 257)), do: "application/x-tar"

  defp match(magic("%PDF-")), do: "application/pdf"
  defp match(magic("%!PS")), do: "application/postscript"
  defp match(magic(~h"042521")), do: "application/postscript"
  defp match(magic(~h"c5d0d3c6")), do: "application/postscript"
  defp match(magic("8BPS")), do: "application/vnd.adobe.photoshop"

  defp match("OggS" <> _ = data) do
    case data do
       magic("OpusHead", 28) -> "audio/opus"
       magic("Speex", 28) -> "audio/ogg"
       magic("\dFLAC", 28) -> "audio/ogg"
       magic(~h"01766f72626973", 28) -> "audio/ogg"
       magic(~h"807468656f7261", 28) -> "video/ogg"
       magic(~h"01766964656f00", 28) -> "video/ogg"
      _ -> "application/ogg"
    end
  end

  defp match(_), do: nil
end
