defmodule FileType.Signature do
  @moduledoc false

  defmacrop sigil_h({:<<>>, _, [data]}, []) do
    Base.decode16!(data, case: :lower)
  end

  defmacrop magic(data, offset \\ 0) do
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacrop ftyp(data) do
    quote do: <<_::binary-size(4), "ftyp", unquote(data)>> <> _
  end

  @spec match(binary) :: binary | nil

  # 2-byte signatures
  def match(magic("BM")), do: "image/bmp"
  def match(magic(~h"0b77")), do: "audio/vnd.dolby.dd-raw"
  def match(magic(~h"7801")), do: "application/x-apple-diskimage"
  def match(magic(~h"4d5a")), do: "application/x-msdownload"
  def match(magic(~h"1fa0")), do: "application/x-compress"
  def match(magic(~h"1f9d")), do: "application/x-compress"

  # 3-byte signatures
  def match(magic("ID3")), do: "audio/mpeg" # FIXME: file-type does a bit more work
  def match(magic(~h"ffd8ff")), do: "image/jpeg"
  def match(magic(~h"4949bc")), do: "image/vnd.ms-photo"
  def match(magic(~h"1f8b")), do: "application/gzip"
  def match(magic(~h"425a68")), do: "application/x-bzip2"
  def match(magic(~h"435753")), do: "application/x-shockwave-flash"
  def match(magic(~h"465753")), do: "application/x-shockwave-flash"

  # 4-byte signatures
  def match(magic(~h"474946")), do: "image/gif"
  def match(magic("FLIF")), do: "image/flif"
  def match(magic("8BPS")), do: "image/vnd.adobe.photoshop"
  def match(magic("WEBP", 8)), do: "image/webp"
  def match(magic("free", 4)), do: "video/quicktime"
  def match(magic("mdat", 4)), do: "video/quicktime"
  def match(magic("moov", 4)), do: "video/quicktime"
  def match(magic("wide", 4)), do: "video/quicktime"
  def match(magic("WAVE", 8)), do: "audio/vnd.wave"
  def match(magic("%PDF-")), do: "application/pdf" # FIXME: Adobe Illustrator
  def match(magic("Rar!")), do: "application/vnd.rar"

  def match(magic("OggS") = data) do
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

  # Postscript
  # FIXME: Some EPS files not matching?
  def match(magic("%!PS") = data) do
    case data do
      magic(" EPSF-", 14) -> "application/eps"
      _ -> "application/postscript"
    end
  end

  # 8-byte signatures
  def match(magic(~h"1a45dfa3")), do: "video/x-matroska"
  def match(magic(~h"89504e47")), do: "image/png"
  def match(magic(~h"49492a00")), do: "image/tiff"
  def match(magic(~h"4d4d002a")), do: "image/tiff"
  def match(magic(~h"504b0304")), do: "application/zip"

  # File-type boxes
  def match(ftyp("heic")), do: "image/heic"
  def match(ftyp("heix")), do: "image/heic"
  def match(ftyp("mif1")), do: "image/heic"
  def match(ftyp("MSNV")), do: "video/mp4"
  def match(ftyp("M4V")), do: "video/mp4"
  def match(ftyp("isom")), do: "video/mp4"
  def match(ftyp("f4v ")), do: "video/mp4"
  def match(ftyp("mp42")), do: "video/mp4"
  def match(ftyp("qt")), do: "video/quicktime"

  # More bytes!
  def match(magic(~h"757374617200", 257)), do: "application/x-tar"
  def match(magic(~h"7573746172202000", 257)), do: "application/x-tar"

  def match(_), do: nil
end
