defmodule FileType do
  import FileType.Macros

  @minimum_bytes 4_100

  @type read_error :: File.posix() | :badarg | :terminated

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
  def get(4 <~> "free" <> _), do: "video/quicktime"
  def get(4 <~> "mdat" <> _), do: "video/quicktime"
  def get(4 <~> "moov" <> _), do: "video/quicktime"
  def get(4 <~> "wide" <> _), do: "video/quicktime"
  def get(~h"1a45dfa3" <> _), do: "video/x-matroska"

  def get("ID3" <> _), do: "audio/mpeg"
  def get(8 <~> "WAV" <> _), do: "audio/x-wav"

  def get("BM" <> _), do: "image/bmp"
  def get("RIFF" <> _), do: "image/webp"
  def get(ftyp("heic")), do: "image/heic"
  def get(ftyp("heix")), do: "image/heic"
  def get(ftyp("mif1")), do: "image/heic"
  def get(~h"89504e47" <> _), do: "image/png"
  def get(~h"ffd8ff" <> _), do: "image/jpeg"
  def get(~h"49492a00" <> _), do: "image/tiff"
  def get(~h"4d4d002a" <> _), do: "image/tiff"

  def get(~h"1f8b" <> _), do: "application/gzip"
  def get(~h"504b0304" <> _), do: "application/zip"
  def get("Rar!" <> _), do: "application/vnd.rar"
  def get(257 <~> ~h"757374617200" <> _), do: "application/x-tar"
  def get(257 <~> ~h"7573746172202000" <> _), do: "application/x-tar"

  def get("%PDF-" <> _), do: "application/pdf"
  def get("%!PS" <> _), do: "application/postscript"
  def get(~h"042521" <> _), do: "application/postscript"
  def get(~h"c5d0d3c6" <> _), do: "application/postscript"
  def get("8BPS" <> _), do: "application/vnd.adobe.photoshop"

  def get(~h"fe370023" <> _), do: "application/msword"
  def get(~h"31be0000" <> _), do: "application/msword"
  def get(~h"504f5e5160" <> _), do: "application/msword"
  def get(~h"dba52d000000" <> _), do: "application/msword"
  def get(2108 <~> "MSWordDoc" <> _), do: "application/msword"
  def get(2112 <~> "MSWordDoc" <> _), do: "application/msword"
  def get(2112 <~> "Microsoft Word document data" <> _), do: "application/msword"
  def get(546 <~> "bjbj" <> _), do: "application/msword"
  def get(546 <~> "jbjb" <> _), do: "application/msword"

  def get("OggS" <> _ = data) do
    case data do
       28 <~> "OpusHead" <> _ -> "audio/opus"
       28 <~> "Speex" <> _ -> "audio/ogg"
       28 <~> "\dFLAC" <> _ -> "audio/ogg"
       28 <~> ~h"01766f72626973" <> _ -> "audio/ogg"
       28 <~> ~h"807468656f7261" <> _ -> "video/ogg"
       28 <~> ~h"01766964656f00" <> _ -> "video/ogg"
      _ -> "application/ogg"
    end
  end

  def get(_), do: nil
end
