defmodule FileType do
  @minimum_bytes 4_100

  @type read_error :: File.posix() | :badarg | :terminated

  defmacrop sigil_h({:<<>>, _, [data]}, []) do
    Base.decode16!(data, case: :lower)
  end

  defmacrop magic(data, offset \\ 0) do
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacrop ftyp(data) do
    quote do: <<_::binary-size(4), "ftyp", unquote(data)>> <> _
  end

  @spec read(binary) :: {:ok, binary} | {:error, read_error}
  def read(path) when is_binary(path) do
    with {:ok, file} <- :file.open(path, [:read, :binary]),
         {:ok, data} <- :file.read(file, @minimum_bytes),
         :ok <- :file.close(file),
         do: {:ok, data}
  end

  @spec fetch(binary) :: {:ok, binary}  | :error
  def fetch(data) do
    case get(data) do
      nil -> :error
      mime -> {:ok, mime}
    end
  end

  @spec get(binary) :: binary | nil
  def get(ftyp("MSNV")), do: "video/mp4"
  def get(ftyp("M4V")), do: "video/mp4"
  def get(ftyp("isom")), do: "video/mp4"
  def get(ftyp("f4v ")), do: "video/mp4"
  def get(ftyp("mp42")), do: "video/mp4"
  def get(ftyp("qt")), do: "video/quicktime"
  def get(magic("free", 4)), do: "video/quicktime"
  def get(magic("mdat", 4)), do: "video/quicktime"
  def get(magic("moov", 4)), do: "video/quicktime"
  def get(magic("wide", 4)), do: "video/quicktime"
  def get(magic(~h"1a45dfa3")), do: "video/x-matroska"

  def get(magic("ID3")), do: "audio/mpeg"
  def get(magic("WAV", 8)), do: "audio/x-wav"

  def get(magic("BM")), do: "image/bmp"
  def get(magic("RIFF")), do: "image/webp"
  def get(ftyp("heic")), do: "image/heic"
  def get(ftyp("heix")), do: "image/heic"
  def get(ftyp("mif1")), do: "image/heic"
  def get(magic(~h"89504e47")), do: "image/png"
  def get(magic(~h"ffd8ff")), do: "image/jpeg"
  def get(magic(~h"49492a00")), do: "image/tiff"
  def get(magic(~h"4d4d002a")), do: "image/tiff"

  def get(magic(~h"1f8b")), do: "application/gzip"
  def get(magic(~h"504b0304")), do: "application/zip"
  def get(magic("Rar!")), do: "application/vnd.rar"
  def get(magic(~h"757374617200", 257)), do: "application/x-tar"
  def get(magic(~h"7573746172202000", 257)), do: "application/x-tar"

  def get(magic("%PDF-")), do: "application/pdf"
  def get(magic("%!PS")), do: "application/postscript"
  def get(magic(~h"042521")), do: "application/postscript"
  def get(magic(~h"c5d0d3c6")), do: "application/postscript"
  def get(magic("8BPS")), do: "application/vnd.adobe.photoshop"

  def get(magic(~h"fe370023")), do: "application/msword"
  def get(magic(~h"31be0000")), do: "application/msword"
  def get(magic(~h"504f5e5160")), do: "application/msword"
  def get(magic(~h"dba52d000000")), do: "application/msword"
  def get(magic("MSWordDoc", 2108)), do: "application/msword"
  def get(magic("MSWordDoc", 2112)), do: "application/msword"
  def get(magic("Microsoft Word document data", 2112)), do: "application/msword"
  def get(magic("bjbj", 546)), do: "application/msword"
  def get(magic("jbjb", 546)), do: "application/msword"

  def get("OggS" <> _ = data) do
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

  def get(_), do: nil
end
