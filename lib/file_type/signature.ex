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

  @spec match(binary) :: {binary, binary} | nil

  # 2-byte signatures
  def match(magic("BM")), do: {"bmp", "image/bmp"}
  def match(magic(~h"0b77")), do: {"ac3", "audio/vnd.dolby.dd-raw"}
  def match(magic(~h"7801")), do: {"dmg", "application/x-apple-diskimage"}
  def match(magic(~h"4d5a")), do: {"exe", "application/x-msdownload"}
  def match(magic(~h"1fa0")), do: {"Z", "application/x-compress"}
  def match(magic(~h"1f9d")), do: {"Z", "application/x-compress"}

  # 3-byte signatures
  def match(magic("ID3")), do: {"mp3", "audio/mpeg"} # FIXME: file-type does a bit more work?
  def match(magic(~h"ffd8ff")), do: {"jpg", "image/jpeg"}
  def match(magic(~h"4949bc")), do: {"jxr", "image/vnd.ms-photo"}
  def match(magic(~h"1f8b")), do: {"gz", "application/gzip"}
  def match(magic(~h"425a68")), do: {"bz2", "application/x-bzip2"}
  def match(magic(~h"435753")), do: {"swf", "application/x-shockwave-flash"}
  def match(magic(~h"465753")), do: {"swf", "application/x-shockwave-flash"}
  def match(magic(~h"474946")), do: {"gif", "image/gif"}

  # 4-byte signatures
  def match(magic("FLIF")), do: {"flif", "image/flif"}
  def match(magic("8BPS")), do: {"psd", "image/vnd.adobe.photoshop"}
  def match(magic("WEBP", 8)), do: {"webp", "image/webp"}
  def match(magic("free", 4)), do: {"mov", "video/quicktime"}
  def match(magic("mdat", 4)), do: {"mov", "video/quicktime"}
  def match(magic("moov", 4)), do: {"mov", "video/quicktime"}
  def match(magic("wide", 4)), do: {"mov", "video/quicktime"}
  def match(magic("WAVE", 8)), do: {"wav", "audio/vnd.wave"}
  def match(magic("%PDF-")), do: {"pdf", "application/pdf"} # FIXME: Adobe Illustrator
  def match(magic("Rar!")), do: {"rar", "application/vnd.rar"}
  def match(magic(~h"c5d0d3c6")), do: {"eps", "application/eps"}

  def match(magic("%!PS") = data) do
    case data do
      magic(" EPSF-", 14) -> {"eps", "application/eps"}
      _ -> {"ps", "application/postscript"}
    end
  end

  def match(magic("OggS") = data) do
    case data do
       magic(~h"4f70757348656164", 28) -> {"opus", "audio/opus"}
       magic(~h"53706565782020", 28) -> {"spx", "audio/ogg"}
       magic(~h"7f464c4143", 28) -> {"oga", "audio/ogg"}
       magic(~h"01766f72626973", 28) -> {"ogg", "audio/ogg"}
       magic(~h"807468656f7261", 28) -> {"ogv", "video/ogg"}
       magic(~h"01766964656f00", 28) -> {"ogm", "video/ogg"}
      _ -> {"ogx", "application/ogg"}
    end
  end

  # 8-byte signatures
  def match(magic(~h"1a45dfa3")), do: {"mkv", "video/x-matroska"}
  def match(magic(~h"89504e47")), do: {"png", "image/png"}
  def match(magic(~h"49492a00")), do: {"tif", "image/tiff"}
  def match(magic(~h"4d4d002a")), do: {"tif", "image/tiff"}
  def match(magic(~h"504b0304")), do: {"zip", "application/zip"}

  # File-type boxes
  def match(ftyp("avif")), do: {"avif", "image/avif"}
  def match(ftyp("mif1")), do: {"heic", "image/heif"}
  def match(ftyp("msf1")), do: {"heic", "image/heif-sequence"}
  def match(ftyp("heic")), do: {"heic", "image/heic"}
  def match(ftyp("heix")), do: {"heic", "image/heic"}
  def match(ftyp("hevc")), do: {"heic", "image/heic-sequence"}
  def match(ftyp("hevx")), do: {"heic", "image/heic-sequence"}
  def match(ftyp("qt  ")), do: {"mov", "video/quicktime"}
  def match(ftyp("M4V ")), do: {"m4v", "video/x-m4v"}
  def match(ftyp("M4A ")), do: {"m4a", "audio/x-m4a"}
  def match(ftyp("M4P ")), do: {"m4p", "video/mp4"}
  def match(ftyp("F4V ")), do: {"f4v", "video/mp4"}
  def match(ftyp("F4P ")), do: {"f4p", "video/mp4"}
  def match(ftyp("M4B ")), do: {"m4b", "audio/mp4"}
  def match(ftyp("F4A ")), do: {"f4a", "audio/mp4"}
  def match(ftyp("F4B ")), do: {"f4b", "audio/mp4"}
  def match(ftyp("crx ")), do: {"cr3", "image/x-canon-cr3"}
  def match(ftyp("mj2s")), do: {"mj2", "video/mj2"}
  def match(ftyp("mjp2")), do: {"mj2", "video/mj2"}
  def match(ftyp("3g2")), do: {"3g2", "video/3gpp2"}
  def match(ftyp("3g")), do: {"3gp", "video/3gpp"}
  def match(ftyp("")), do: {"mp4", "video/mp4"}

  # More bytes!
  def match(magic(~h"757374617200", 257)), do: {"tar", "application/x-tar"}
  def match(magic(~h"7573746172202000", 257)), do: {"tar", "application/x-tar"}

  def match(_), do: nil
end
