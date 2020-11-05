defmodule FileType.Magic do
  @moduledoc false

  import FileType.Utils

  @type ext :: binary()
  @type mime :: binary()
  @type result :: {ext(), mime()}

  @spec run(binary()) :: result() | nil
  def run(content)

  def run("BM" <> _), do: {"bmp", "image/bmp"}
  def run("ID3" <> _), do: {"mp3", "audio/mpeg"}
  def run("MP+" <> _), do: {"mpc", "audio/x-musepack"}
  def run("FLIF" <> _), do: {"flif", "image/flif"}
  def run("8BPS" <> _), do: {"psd", "image/vnd.adobe.photoshop"}
  def run("icns" <> _), do: {"icns", "image/icns"}
  def run("MPCK" <> _), do: {"mpc", "audio/x-musepack"}
  def run("FORM" <> _), do: {"aif", "audio/aiff"}
  def run("MThd" <> _), do: {"mid", "audio/midi"}
  def run("fLaC" <> _), do: {"flac", "audio/x-flac"}
  def run("IMPM" <> _), do: {"it", "audio/x-it"}
  def run("DSD " <> _), do: {"dsf", "audio/x-dsf"}
  def run("wvpk" <> _), do: {"wv", "audio/wavpack"}
  def run("MAC " <> _), do: {"ape", "audio/ape"}
  def run("%PDF-" <> _), do: {"pdf", "application/pdf"}
  def run("LZIP" <> _), do: {"lz", "application/x-lzip"}
  def run("SQLi" <> _), do: {"sqlite", "application/x-sqlite3"}
  def run("Cr24" <> _), do: {"crx", "application/x-google-chrome-extension"}
  def run("MSCF" <> _), do: {"cab", "application/vnd.ms-cab-compressed"}
  def run("ISc(" <> _), do: {"cab", "application/vnd.ms-cab-compressed"}
  def run("#!AMR" <> _), do: {"amr", "audio/amr"}
  def run("{\\rtf" <> _), do: {"rtf", "application/rtf"}
  def run(~h"0b77" <> _), do: {"ac3", "audio/vnd.dolby.dd-raw"}
  def run(~h"7801" <> _), do: {"dmg", "application/x-apple-diskimage"}
  def run(~h"4d5a" <> _), do: {"exe", "application/x-msdownload"}
  def run(~h"1fa0" <> _), do: {"Z", "application/x-compress"}
  def run(~h"1f9d" <> _), do: {"Z", "application/x-compress"}
  def run(~h"ffd8ff" <> _), do: {"jpg", "image/jpeg"}
  def run(~h"4949bc" <> _), do: {"jxr", "image/vnd.ms-photo"}
  def run(~h"1f8b" <> _), do: {"gz", "application/gzip"}
  def run(~h"425a68" <> _), do: {"bz2", "application/x-bzip2"}
  def run(~h"435753" <> _), do: {"swf", "application/x-shockwave-flash"}
  def run(~h"465753" <> _), do: {"swf", "application/x-shockwave-flash"}
  def run(~h"474946" <> _), do: {"gif", "image/gif"}
  def run(~h"1a45dfa3" <> _), do: {"mkv", "video/x-matroska"}
  def run(~h"464c5601" <> _), do: {"flv", "video/x-flv"}
  def run(~h"89504e47" <> _), do: {"png", "image/png"}
  def run(~h"425047fb" <> _), do: {"bpg", "image/bpg"}
  def run(~h"4d4d002a" <> _), do: {"tif", "image/tiff"}
  def run(~h"c5d0d3c6" <> _), do: {"eps", "application/eps"}
  def run(~h"0061736d" <> _), do: {"wasm", "application/wasm"}
  def run(~h"d4c3b2a1" <> _), do: {"pcap", "application/vnd.tcpdump.pcap"}
  def run(~h"a1b2c3d4" <> _), do: {"pcap", "application/vnd.tcpdump.pcap"}
  def run(~h"4e45531a" <> _), do: {"nes", "application/x-nintendo-nes-rom"}
  def run(~h"edabeedb" <> _), do: {"rpm", "application/x-rpm"}
  def run(~h"4f54544f00" <> _), do: {"otf", "font/otf"}
  def run(~h"0001000000" <> _), do: {"ttf", "font/ttf"}
  def run(~h"000001ba21" <> _), do: {"mpg", "video/MP1S"}
  def run(~h"000001ba44" <> _), do: {"mpg", "video/MP2P"}
  def run("<?xml " <> _), do: {"xml", "application/xml"}
  def run("BEGIN:" <> _), do: {"ics", "text/calendar"}
  def run("solid " <> _), do: {"stl", "model/stl"}
  def run(~h"fd377a585a00" <> _), do: {"xz", "application/x-xz"}
  def run(~h"526172211a07" <> _), do: {"rar", "application/vnd.rar"}
  def run(~h"377abcaf271c" <> _), do: {"7z", "application/x-7z-compressed"}
  def run("BLENDER" <> _), do: {"blend", "application/x-blender"}
  def run("wOFFOTTO" <> _), do: {"woff", "font/woff"}
  def run("wOF2OTTO" <> _), do: {"woff2", "font/woff2"}
  def run(~h"774f464600010000" <> _), do: {"woff", "font/woff"}
  def run(~h"774f463200010000" <> _), do: {"woff2", "font/woff2"}
  def run(~h"4152524f57310000" <> _), do: {"arrow", "application/x-apache-arrow"}
  def run(~h"676c544602000000" <> _), do: {"glb", "model/gltf-binary"}
  def run(<<_::binary-4, ~h"304d4945">> <> _), do: {"mie", "application/x-mie"}
  def run(~h"4949524f0800000018" <> _), do: {"orf", "image/x-olympus-orf"}
  def run(~h"3026b2758e66cf11a6d9" <> _), do: {"asf", "application/vnd.ms-asf"}
  def run(<<_::binary-8, "WEBP">> <> _), do: {"webp", "image/webp"}
  def run(~h"ab4b5458203131bb0d0a1a0a" <> _), do: {"ktx", "image/ktx"}
  def run(~h"494955001800000088e774d8" <> _), do: {"rw2", "image/x-panasonic-rw2"}
  def run(<<"RIFF", _::binary-4, "AVI">> <> _), do: {"avi", "video/vnd.avi"}
  def run(<<"RIFF", _::binary-4, "WAVE">> <> _), do: {"wav", "audio/vnd.wave"}
  def run(<<"RIFF", _::binary-4, "QLCM">> <> _), do: {"qcp", "audio/qcelp"}
  def run("Extended Module:" <> _), do: {"xm", "audio/x-xm"}
  def run("FUJIFILMCCD-RAW" <> _), do: {"raf", "image/x-fujifilm-raf"}
  def run("Creative Voice File" <> _), do: {"voc", "audio/x-voc"}
  def run(<<_::binary-44, "SCRM">> <> _), do: {"s3m", "audio/x-s3m"}
  def run(<<_::binary-257, "ustar">> <> _), do: {"tar", "application/x-tar"}
  def run(<<_::binary-128, ~h"4449434d">> <> _), do: {"dcm", "application/dicom"}
  def run(<<_::binary-4, "G", _::binary-191, "G">> <> _), do: {"mts", "video/mp2t"}

  def run(<<_::binary-60, ~h"424f4f4b4d4f4249">> <> _) do
    {"mobi", "application/x-mobipocket-ebook"}
  end

  def run(~h"060e2b34020501010d0102010102" <> _) do
    {"mxf", "application/mxf"}
  end

  def run(<<_::binary-2, ~h"270a00000000000000000000">> <> _) do
    {"shp", "application/x-esri-shape"}
  end

  def run(~h"626f6f6b000000006d61726b00000000" <> _) do
    {"alias", "application/x.apple.alias"}
  end

  def run(~h"0606edf5d81d46e5bd31efe7fe74b71d" <> _) do
    {"indd", "application/x-indesign"}
  end

  def run("-----BEGIN PGP MESSAGE-----" <> _) do
    {"pgp", "application/pgp-encrypted"}
  end

  def run(~h"4c0000000114020000000000c000000000000046" <> _) do
    {"lnk", "application/x.ms.shortcut"}
  end

  def run(~h"fffeff0e53006b0065007400630068005500700020004d006f00640065006c00" <> _) do
    {"skp", "application/vnd.sketchup.skp"}
  end

  for eot <- [~h"000001", ~h"010002", ~h"020002"] do
    def run(<<_::binary-8, unquote(eot), _::binary-23, 0x4C, 0x50>> <> _) do
      {"eot", "application/vnd.ms-fontobject"}
    end
  end

  for lzh <- ~w(lh0 lh1 lh2 lh3 lh4 lh5 lh6 lh7 lhd lzs lz4 lzd) do
    def run(<<_::binary-2, "-", unquote(lzh), "-">> <> _) do
      {"lzh", "application/x-lzh-compressed"}
    end
  end

  for mov <- ~w(free mdat moov wide) do
    def run(<<_::binary-4, unquote(mov)>> <> _) do
      {"mov", "video/quicktime"}
    end
  end

  def run("%!PS" <> data) do
    case data do
      <<_::binary-10, " EPSF-">> <> _ -> {"eps", "application/eps"}
      _ -> {"ps", "application/postscript"}
    end
  end

  def run("!<arch>" <> data) do
    case data do
      <<_::binary-1, "debian-binary">> <> _ -> {"deb", "application/x-deb"}
      _ -> {"ar", "application/x-unix-archive"}
    end
  end

  def run(~h"49492a00" <> data) do
    case data do
      <<_::binary-4, "CR">> <> _ -> {"cr2", "image/x-canon-cr2"}
      <<_::binary-4, ~h"1c00fe00">> <> _ -> {"nef", "image/x-nikon-nef"}
      <<_::binary-4, ~h"1f000b00">> <> _ -> {"nef", "image/x-nikon-nef"}
      <<_::binary-4, ~h"2d00fe00">> <> _ -> {"dng", "image/x-adobe-dng"}
      <<_::binary-4, ~h"2700fe00">> <> _ -> {"dng", "image/x-adobe-dng"}
      <<_::binary-5, ~h"00fe00040001000000010000000301">> <> _ -> {"arw", "image/x-sony-arw"}
      _ -> {"tif", "image/tiff"}
    end
  end

  def run(~h"0000000c6a5020200d0a870a" <> data) do
    case data do
      <<_::binary-8, "jp2 ">> <> _ -> {"jp2", "image/jp2"}
      <<_::binary-8, "jpx ">> <> _ -> {"jpx", "image/jpx"}
      <<_::binary-8, "jpm ">> <> _ -> {"jpm", "image/jpm"}
      <<_::binary-8, "mjp2">> <> _ -> {"mj2", "image/mj2"}
      <<_::binary-8, "mj2s">> <> _ -> {"mj2", "image/mj2"}
      _ -> nil
    end
  end

  def run("OggS" <> data) do
    case data do
      <<_::binary-24, ~h"4f70757348656164">> <> _ -> {"opus", "audio/opus"}
      <<_::binary-24, ~h"53706565782020">> <> _ -> {"spx", "audio/ogg"}
      <<_::binary-24, ~h"7f464c4143">> <> _ -> {"oga", "audio/ogg"}
      <<_::binary-24, ~h"01766f72626973">> <> _ -> {"ogg", "audio/ogg"}
      <<_::binary-24, ~h"807468656f7261">> <> _ -> {"ogv", "video/ogg"}
      <<_::binary-24, ~h"01766964656f00">> <> _ -> {"ogm", "video/ogg"}
      _ -> {"ogx", "application/ogg"}
    end
  end

  def run(<<_::binary-4, "ftyp", type::binary-4>> <> _) do
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
      "mj2s" -> {"mj2", "video/mj2"}
      "mjp2" -> {"mj2", "video/mj2"}
      "crx " -> {"cr3", "image/x-canon-cr3"}
      "3g2" <> _ -> {"3g2", "video/3gpp2"}
      "3g" <> _ -> {"3gp", "video/3gpp"}
      _ -> {"mp4", "video/mp4"}
    end
  end

  # These patterns are likely to produce false positives.
  def run(~h"0001000000" <> _), do: {"ttf", "font/ttf"}
  def run(~h"00000100" <> _), do: {"ico", "image/x-icon"}
  def run(~h"00000200" <> _), do: {"cur", "image/x-icon"}

  def run(_), do: nil
end
