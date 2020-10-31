defmodule FileType.Signature do
  @moduledoc false

  defmacrop sigil_h({:<<>>, _, [data]}, []) do
    Base.decode16!(data, case: :lower)
  end

  defmacrop magic(data, offset \\ 0) do
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
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
  def match(magic("ID3")), do: {"mp3", "audio/mpeg"}
  def match(magic("MP+")), do: {"mpc", "audio/x-musepack"}
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
  def match(magic("icns")), do: {"icns", "image/icns"}
  def match(magic("WEBP", 8)), do: {"webp", "image/webp"}
  def match(magic("free", 4)), do: {"mov", "video/quicktime"}
  def match(magic("mdat", 4)), do: {"mov", "video/quicktime"}
  def match(magic("moov", 4)), do: {"mov", "video/quicktime"}
  def match(magic("wide", 4)), do: {"mov", "video/quicktime"}
  def match(magic("WAVE", 8)), do: {"wav", "audio/vnd.wave"}
  def match(magic("MPCK")), do: {"mpc", "audio/x-musepack"}
  def match(magic("FORM")), do: {"aif", "audio/aiff"}
  def match(magic("MThd")), do: {"mid", "audio/midi"}
  def match(magic("%PDF-")), do: {"pdf", "application/pdf"}
  def match(magic("Rar!")), do: {"rar", "application/vnd.rar"}
  def match(magic(~h"c5d0d3c6")), do: {"eps", "application/eps"}
  def match(magic(~h"1a45dfa3")), do: {"mkv", "video/x-matroska"}
  def match(magic(~h"89504e47")), do: {"png", "image/png"}
  def match(magic(~h"49492a00")), do: {"tif", "image/tiff"}
  def match(magic(~h"4d4d002a")), do: {"tif", "image/tiff"}
  def match(magic(~h"504b0304")), do: {"zip", "application/zip"}
  def match(magic(~h"d4c3b2a1")), do: {"pcap", "application/vnd.tcpdump.pcap"}
  def match(magic(~h"a1b2c3d4")), do: {"pcap", "application/vnd.tcpdump.pcap"}

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
  def match(magic("wOFFOTTO")), do: {"woff", "font/woff"}
  def match(magic("wOF2OTTO")), do: {"woff2", "font/woff2"}
  def match(magic(~h"774f464600010000")), do: {"woff", "font/woff"}
  def match(magic(~h"774f463200010000")), do: {"woff2", "font/woff2"}

  # File-type boxes
  def match(<<_::binary-size(4), "ftyp", type::binary-size(4)>> <> _) do
    case String.replace(type, "\0", " ") do
      "avif" -> {"avif", "image/avif"}
      "mif1" -> {"heic", "image/heif"}
      "msf1" -> {"heic", "image/heif-sequence"}
      "heic" -> {"heic", "image/heic"}
      "heix" -> {"heic", "image/heic"}
      "hevc" -> {"heic", "image/heic-sequence"}
      "hevx" -> {"heic", "image/heic-sequence"}
      "qt  " -> {"mov", "video/quicktime"}
      "M4V " -> {"m4v", "video/x-m4v"}
      "M4A " -> {"m4a", "audio/x-m4a"}
      "M4P " -> {"m4p", "video/mp4"}
      "F4V " -> {"f4v", "video/mp4"}
      "F4P " -> {"f4p", "video/mp4"}
      "M4B " -> {"m4b", "audio/mp4"}
      "F4A " -> {"f4a", "audio/mp4"}
      "F4B " -> {"f4b", "audio/mp4"}
      "crx " -> {"cr3", "image/x-canon-cr3"}
      "3g2" <> _ -> {"3g2", "video/3gpp2"}
      "3g" <> _ -> {"3gp", "video/3gpp"}
      "mj" <> _ -> {"mj2", "video/mj2"}
      _ -> {"mp4", "video/mp4"}
    end
  end

  # More bytes!
  def match(magic(~h"757374617200", 257)), do: {"tar", "application/x-tar"}
  def match(magic(~h"7573746172202000", 257)), do: {"tar", "application/x-tar"}

  def match(_), do: nil
end
