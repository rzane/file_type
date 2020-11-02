defmodule FileType.Signature do
  @moduledoc false

  import FileType.Utils

  @spec detect(binary) :: {binary, binary} | nil
  def detect(data)

  # 2 bytes
  def detect(~m"BM"), do: {"bmp", "image/bmp"}
  def detect(~m"0b77"h), do: {"ac3", "audio/vnd.dolby.dd-raw"}
  def detect(~m"7801"h), do: {"dmg", "application/x-apple-diskimage"}
  def detect(~m"4d5a"h), do: {"exe", "application/x-msdownload"}
  def detect(~m"1fa0"h), do: {"Z", "application/x-compress"}
  def detect(~m"1f9d"h), do: {"Z", "application/x-compress"}

  # 3 bytes
  def detect(~m"ID3"), do: {"mp3", "audio/mpeg"}
  def detect(~m"MP+"), do: {"mpc", "audio/x-musepack"}
  def detect(~m"ffd8ff"h), do: {"jpg", "image/jpeg"}
  def detect(~m"4949bc"h), do: {"jxr", "image/vnd.ms-photo"}
  def detect(~m"1f8b"h), do: {"gz", "application/gzip"}
  def detect(~m"425a68"h), do: {"bz2", "application/x-bzip2"}
  def detect(~m"435753"h), do: {"swf", "application/x-shockwave-flash"}
  def detect(~m"465753"h), do: {"swf", "application/x-shockwave-flash"}
  def detect(~m"474946"h), do: {"gif", "image/gif"}

  # 4 bytes
  def detect(~m"FLIF"), do: {"flif", "image/flif"}
  def detect(~m"8BPS"), do: {"psd", "image/vnd.adobe.photoshop"}
  def detect(~m"icns"), do: {"icns", "image/icns"}
  def detect(~m"MPCK"), do: {"mpc", "audio/x-musepack"}
  def detect(~m"FORM"), do: {"aif", "audio/aiff"}
  def detect(~m"MThd"), do: {"mid", "audio/midi"}
  def detect(~m"fLaC"), do: {"flac", "audio/x-flac"}
  def detect(~m"IMPM"), do: {"it", "audio/x-it"}
  def detect(~m"DSD "), do: {"dsf", "audio/x-dsf"}
  def detect(~m"wvpk"), do: {"wv", "audio/wavpack"}
  def detect(~m"MAC "), do: {"ape", "audio/ape"}
  def detect(~m"%PDF-"), do: {"pdf", "application/pdf"}
  def detect(~m"LZIP"), do: {"lz", "application/x-lzip"}
  def detect(~m"SQLi"), do: {"sqlite", "application/x-sqlite3"}
  def detect(~m"Cr24"), do: {"crx", "application/x-google-chrome-extension"}
  def detect(~m"MSCF"), do: {"cab", "application/vnd.ms-cab-compressed"}
  def detect(~m"ISc("), do: {"cab", "application/vnd.ms-cab-compressed"}
  def detect(~m"1a45dfa3"h), do: {"mkv", "video/x-matroska"}
  def detect(~m"464c5601"h), do: {"flv", "video/x-flv"}
  def detect(~m"89504e47"h), do: {"png", "image/png"}
  def detect(~m"425047fb"h), do: {"bpg", "image/bpg"}
  def detect(~m"4d4d002a"h), do: {"tif", "image/tiff"}
  def detect(~m"00000100"h), do: {"ico", "image/x-icon"}
  def detect(~m"00000200"h), do: {"cur", "image/x-icon"}
  def detect(~m"c5d0d3c6"h), do: {"eps", "application/eps"}
  def detect(~m"504b0304"h), do: {"zip", "application/zip"}
  def detect(~m"0061736d"h), do: {"wasm", "application/wasm"}
  def detect(~m"d4c3b2a1"h), do: {"pcap", "application/vnd.tcpdump.pcap"}
  def detect(~m"a1b2c3d4"h), do: {"pcap", "application/vnd.tcpdump.pcap"}
  def detect(~m"4e45531a"h), do: {"nes", "application/x-nintendo-nes-rom"}
  def detect(~m"edabeedb"h), do: {"rpm", "application/x-rpm"}

  # 5 bytes
  def detect(~m"#!AMR"), do: {"amr", "audio/amr"}
  def detect(~m"{\rtf"), do: {"rtf", "application/rtf"}
  def detect(~m"4f54544f00"h), do: {"otf", "font/otf"}
  def detect(~m"0001000000"h), do: {"ttf", "font/ttf"}

  # 6 bytes
  def detect(~m"<?xml "), do: {"xml", "application/xml"}
  def detect(~m"BEGIN:"), do: {"ics", "text/calendar"}
  def detect(~m"solid "), do: {"stl", "model/stl"}
  def detect(~m"fd377a585a00"h), do: {"xz", "application/x-xz"}
  def detect(~m"526172211a07"h), do: {"rar", "application/vnd.rar"}
  def detect(~m"377abcaf271c"h), do: {"7z", "application/x-7z-compressed"}

  # 7 bytes
  def detect(~m"BLENDER"), do: {"blend", "application/x-blender"}
  def detect(~m"2::-lh0-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh1-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh2-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh3-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh4-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh5-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh6-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lh7-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lzs-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lz4-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lz5-"o), do: {"lzh", "application/x-lzh-compressed"}
  def detect(~m"2::-lhd-"o), do: {"lzh", "application/x-lzh-compressed"}

  # 8 bytes
  def detect(~m"4::free"o), do: {"mov", "video/quicktime"}
  def detect(~m"4::mdat"o), do: {"mov", "video/quicktime"}
  def detect(~m"4::moov"o), do: {"mov", "video/quicktime"}
  def detect(~m"4::wide"o), do: {"mov", "video/quicktime"}
  def detect(~m"wOFFOTTO"), do: {"woff", "font/woff"}
  def detect(~m"wOF2OTTO"), do: {"woff2", "font/woff2"}
  def detect(~m"774f464600010000"h), do: {"woff", "font/woff"}
  def detect(~m"774f463200010000"h), do: {"woff2", "font/woff2"}
  def detect(~m"4152524f57310000"h), do: {"arrow", "application/x-apache-arrow"}
  def detect(~m"676c544602000000"h), do: {"glb", "model/gltf-binary"}
  def detect(~m"d0cf11e0a1b11ae1"h), do: {"cfb", "application/x-cfb"}
  def detect(~m"4::304d4945"oh), do: {"mie", "application/x-mie"}

  # 9 bytes
  def detect(~m"4949524f0800000018"h), do: {"orf", "image/x-olympus-orf"}

  # 10 bytes
  def detect(~m"3026b2758e66cf11a6d9"h), do: {"asf", "application/vnd.ms-asf"}

  # 12 bytes
  def detect(~m"8::WEBP"o), do: {"webp", "image/webp"}
  def detect(~m"ab4b5458203131bb0d0a1a0a"h), do: {"ktx", "image/ktx"}
  def detect(~m"494955001800000088e774d8"h), do: {"rw2", "image/x-panasonic-rw2"}
  def detect(<<"RIFF", _::binary(4), "AVI">> <> _), do: {"avi", "video/vnd.avi"}
  def detect(<<"RIFF", _::binary(4), "WAVE">> <> _), do: {"wav", "audio/vnd.wave"}
  def detect(<<"RIFF", _::binary(4), "QLCM">> <> _), do: {"qcp", "audio/qcelp"}

  def detect(~m"4::ftyp"o = data) do
    data
    |> binary_part(8, 4)
    |> String.replace("\0", " ")
    |> case do
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

  # 14 bytes
  def detect(~m"060e2b34020501010d0102010102"h), do: {"mxf", "application/mxf"}
  def detect(~m"2::270a00000000000000000000"oh), do: {"shp", "application/x-esri-shape"}

  # 15 bytes
  def detect(~m"FUJIFILMCCD-RAW"), do: {"raf", "image/x-fujifilm-raf"}

  # 16 bytes
  def detect(~m"Extended Module:"), do: {"xm", "audio/x-xm"}
  def detect(~m"626f6f6b000000006d61726b00000000"h), do: {"alias", "application/x.apple.alias"}
  def detect(~m"0606edf5d81d46e5bd31efe7fe74b71d"h), do: {"indd", "application/x-indesign"}

  # 19 bytes
  def detect(~m"Creative Voice File"), do: {"voc", "audio/x-voc"}

  def detect(~m"%!PS" = data) do
    case data do
      ~m"14:: EPSF-"o -> {"eps", "application/eps"}
      _ -> {"ps", "application/postscript"}
    end
  end

  # 20 bytes

  def detect(~m"4c0000000114020000000000c000000000000046"h),
    do: {"lnk", "application/x.ms.shortcut"}

  # 21 bytes
  def detect(~m"!<arch>" = data) do
    case binary_part(data, 8, 13) do
      "debian-binary" -> {"deb", "application/x-deb"}
      _ -> {"ar", "application/x-unix-archive"}
    end
  end

  # 24 bytes
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

  def detect(~m"0000000c6a5020200d0a870a"h = data) do
    case binary_part(data, 20, 4) do
      "jp2 " -> {"jp2", "image/jp2"}
      "jpx " -> {"jpx", "image/jpx"}
      "jpm " -> {"jpm", "image/jpm"}
      "mjp2" -> {"mj2", "image/mj2"}
      "mj2s" -> {"mj2", "image/mj2"}
      _ -> nil
    end
  end

  # 25 bytes
  for eot <- [<<0x00, 0x00, 0x01>>, <<0x01, 0x00, 0x02>>, <<0x02, 0x00, 0x02>>] do
    def detect(<<_::binary(8), unquote(eot), _::binary(23), 0x4C, 0x50>> <> _),
      do: {"eot", "application/vnd.ms-fontobject"}
  end

  # 27 bytes
  def detect(~m"-----BEGIN PGP MESSAGE-----"), do: {"pgp", "application/pgp-encrypted"}

  # 32 bytes
  def detect(~m"fffeff0e53006b0065007400630068005500700020004d006f00640065006c00"h),
    do: {"skp", "application/vnd.sketchup.skp"}

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

  # 48 bytes
  def detect(~m"44::SCRM"o), do: {"s3m", "audio/x-s3m"}

  # 68 bytes
  def detect(~m"60::424f4f4b4d4f4249"oh), do: {"mobi", "application/x-mobipocket-ebook"}

  # 132 bytes
  def detect(~m"128::4449434d"oh), do: {"dcm", "application/dicom"}

  # 263 bytes
  def detect(~m"257::757374617200"oh), do: {"tar", "application/x-tar"}

  # 265 bytes
  def detect(~m"257::7573746172202000"oh), do: {"tar", "application/x-tar"}

  # Oh, no. Undetected file!
  def detect(_), do: nil
end
