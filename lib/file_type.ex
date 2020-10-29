defmodule FileType do
  import FileType.Macros

  @minimum_bytes 4_100

  @spec from_path(binary) :: {:ok, binary} | {:error, File.posix() | :unrecognized}
  def from_path(path) when is_binary(path) do
    with {:ok, file} <- :file.open(path, [:read, :binary]),
         {:ok, data} <- :file.read(file, @minimum_bytes),
         :ok <- :file.close(file) do
      case detect(data) do
        nil -> {:error, :unrecognized}
        mime -> {:ok, mime}
      end
    end
  end

  @spec detect(binary) :: binary | nil
  def detect(ftyp("MSNV")), do: "video/mp4"
  def detect(ftyp("M4V")), do: "video/mp4"
  def detect(ftyp("isom")), do: "video/mp4"
  def detect(ftyp("f4v ")), do: "video/mp4"
  def detect(ftyp("mp42")), do: "video/mp4"
  def detect(ftyp("qt")), do: "video/quicktime"
  def detect(4 <~> "free" <> _), do: "video/quicktime"
  def detect(4 <~> "mdat" <> _), do: "video/quicktime"
  def detect(4 <~> "moov" <> _), do: "video/quicktime"
  def detect(4 <~> "wide" <> _), do: "video/quicktime"
  def detect(~h"1a45dfa3" <> _), do: "video/x-matroska"

  def detect("ID3" <> _), do: "audio/mpeg"
  def detect(8 <~> "WAV" <> _), do: "audio/x-wav"

  def detect("BM" <> _), do: "image/bmp"
  def detect("RIFF" <> _), do: "image/webp"
  def detect(ftyp("heic")), do: "image/heic"
  def detect(ftyp("heix")), do: "image/heic"
  def detect(ftyp("mif1")), do: "image/heic"
  def detect(~h"89504e47" <> _), do: "image/png"
  def detect(~h"ffd8ff" <> _), do: "image/jpeg"
  def detect(~h"49492a00" <> _), do: "image/tiff"
  def detect(~h"4d4d002a" <> _), do: "image/tiff"

  def detect(~h"1f8b" <> _), do: "application/gzip"
  def detect(~h"504b0304" <> _), do: "application/zip"
  def detect("Rar!" <> _), do: "application/vnd.rar"
  def detect(257 <~> ~h"757374617200" <> _), do: "application/x-tar"
  def detect(257 <~> ~h"7573746172202000" <> _), do: "application/x-tar"

  def detect("%PDF-" <> _), do: "application/pdf"
  def detect("%!PS" <> _), do: "application/postscript"
  def detect(~h"042521" <> _), do: "application/postscript"
  def detect(~h"c5d0d3c6" <> _), do: "application/postscript"
  def detect("8BPS" <> _), do: "application/vnd.adobe.photoshop"

  def detect(~h"fe370023" <> _), do: "application/msword"
  def detect(~h"31be0000" <> _), do: "application/msword"
  def detect(~h"504f5e5160" <> _), do: "application/msword"
  def detect(~h"dba52d000000" <> _), do: "application/msword"
  def detect(2108 <~> "MSWordDoc" <> _), do: "application/msword"
  def detect(2112 <~> "MSWordDoc" <> _), do: "application/msword"
  def detect(2112 <~> "Microsoft Word document data" <> _), do: "application/msword"
  def detect(546 <~> "bjbj" <> _), do: "application/msword"
  def detect(546 <~> "jbjb" <> _), do: "application/msword"

  def detect("OggS" <> _ = data) do
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

  def detect(_), do: nil
end
