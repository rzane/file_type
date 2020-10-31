defmodule FileType.Signature do
  @moduledoc false

  import FileType.Utils

  @spec detect(binary) :: {binary, binary} | nil
  def detect(data)

  # 2-byte signatures
  def detect(~m"BM"), do: {"bmp", "image/bmp"}
  def detect(~m"0b77"h), do: {"ac3", "audio/vnd.dolby.dd-raw"}
  def detect(~m"7801"h), do: {"dmg", "application/x-apple-diskimage"}
  def detect(~m"4d5a"h), do: {"exe", "application/x-msdownload"}
  def detect(~m"1fa0"h), do: {"Z", "application/x-compress"}
  def detect(~m"1f9d"h), do: {"Z", "application/x-compress"}

  # 3-byte signatures
  def detect(~m"ID3"), do: {"mp3", "audio/mpeg"}
  def detect(~m"MP+"), do: {"mpc", "audio/x-musepack"}
  def detect(~m"ffd8ff"h), do: {"jpg", "image/jpeg"}
  def detect(~m"4949bc"h), do: {"jxr", "image/vnd.ms-photo"}
  def detect(~m"1f8b"h), do: {"gz", "application/gzip"}
  def detect(~m"425a68"h), do: {"bz2", "application/x-bzip2"}
  def detect(~m"435753"h), do: {"swf", "application/x-shockwave-flash"}
  def detect(~m"465753"h), do: {"swf", "application/x-shockwave-flash"}
  def detect(~m"474946"h), do: {"gif", "image/gif"}

  # 4-byte signatures
  def detect(~m"FLIF"), do: {"flif", "image/flif"}
  def detect(~m"8BPS"), do: {"psd", "image/vnd.adobe.photoshop"}
  def detect(~m"icns"), do: {"icns", "image/icns"}
  def detect(~m"MPCK"), do: {"mpc", "audio/x-musepack"}
  def detect(~m"FORM"), do: {"aif", "audio/aiff"}
  def detect(~m"MThd"), do: {"mid", "audio/midi"}
  def detect(~m"fLaC"), do: {"flac", "audio/x-flac"}
  def detect(~m"DSD "), do: {"dsf", "audio/x-dsf"}
  def detect(~m"wvpk"), do: {"wv", "audio/wavpack"}
  def detect(~m"MAC "), do: {"ape", "audio/ape"}
  def detect(~m"%PDF-"), do: {"pdf", "application/pdf"}
  def detect(~m"Rar!"), do: {"rar", "application/vnd.rar"}
  def detect(~m"LZIP"), do: {"lz", "application/x-lzip"}
  def detect(~m"c5d0d3c6"h), do: {"eps", "application/eps"}
  def detect(~m"1a45dfa3"h), do: {"mkv", "video/x-matroska"}
  def detect(~m"89504e47"h), do: {"png", "image/png"}
  def detect(~m"425047fb"h), do: {"bpg", "image/bpg"}
  def detect(~m"504b0304"h), do: {"zip", "application/zip"}
  def detect(~m"0061736d"h), do: {"wasm", "application/wasm"}
  def detect(~m"d4c3b2a1"h), do: {"pcap", "application/vnd.tcpdump.pcap"}
  def detect(~m"a1b2c3d4"h), do: {"pcap", "application/vnd.tcpdump.pcap"}

  def detect(~m"%!PS" = data) do
    case data do
      ~m"14:: EPSF-"o -> {"eps", "application/eps"}
      _ -> {"ps", "application/postscript"}
    end
  end

  def detect(~m"OggS" = data) do
    case data do
      ~m"28::4f70757348656164"oh -> {"opus", "audio/opus"}
      ~m"28::53706565782020"oh -> {"spx", "audio/ogg"}
      ~m"28::7f464c4143"oh -> {"oga", "audio/ogg"}
      ~m"28::01766f72626973"oh -> {"ogg", "audio/ogg"}
      ~m"28::807468656f7261"oh -> {"ogv", "video/ogg"}
      ~m"28::01766964656f00"oh -> {"ogm", "video/ogg"}
      _ -> {"ogx", "application/ogg"}
    end
  end

  def detect(~m"4d4d002a"h), do: {"tif", "image/tiff"}

  def detect(~m"49492a00"h = data) do
    case data do
      ~m"8::CR"o -> {"cr2", "image/x-canon-cr2"}
      ~m"8::1c00fe00"oh -> {"nef", "image/x-nikon-nef"}
      ~m"8::1f000b00"oh -> {"nef", "image/x-nikon-nef"}
      ~m"8::2d00fe00"oh -> {"dng", "image/x-adobe-dng"}
      ~m"8::2700fe00"oh -> {"dng", "image/x-adobe-dng"}
      ~m"9::00fe00040001000000010000000301"oh -> {"arw", "image/x-sony-arw"}
      _ -> {"tif", "image/tiff"}
    end
  end

  # 8-byte signatures
  def detect(~m"4::free"o), do: {"mov", "video/quicktime"}
  def detect(~m"4::mdat"o), do: {"mov", "video/quicktime"}
  def detect(~m"4::moov"o), do: {"mov", "video/quicktime"}
  def detect(~m"4::wide"o), do: {"mov", "video/quicktime"}
  def detect(~m"wOFFOTTO"), do: {"woff", "font/woff"}
  def detect(~m"wOF2OTTO"), do: {"woff2", "font/woff2"}
  def detect(~m"774f464600010000"h), do: {"woff", "font/woff"}
  def detect(~m"774f463200010000"h), do: {"woff2", "font/woff2"}

  # 12-byte signatures
  def detect(~m"8::WEBP"o), do: {"webp", "image/webp"}
  def detect(~m"8::WAVE"o), do: {"wav", "audio/vnd.wave"}

  def detect(<<_::binary-size(4), "ftyp", type::binary-size(4)>> <> _) do
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
  def detect(~m"257::757374617200"oh), do: {"tar", "application/x-tar"}
  def detect(~m"257::7573746172202000"oh), do: {"tar", "application/x-tar"}

  def detect(_), do: nil
end
