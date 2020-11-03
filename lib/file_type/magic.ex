defmodule FileType.Magic do
  @moduledoc false

  import FileType.Utils

  alias FileType.Zip
  alias FileType.CFB
  alias FileType.Fallback

  @size 40
  @type result :: {:ok, {binary, binary}} | {:error, FileType.error()}

  @spec detect(IO.device()) :: result
  def detect(io) do
    case :file.read(io, @size) do
      {:ok, data} ->
        detect(io, data)

      {:error, reason} ->
        {:error, reason}

      :eof ->
        {:error, :unrecognized}
    end
  end

  defp ok(ext, mime), do: {:ok, {ext, mime}}

  # 2 bytes
  defp detect(_, ~m"BM"), do: ok("bmp", "image/bmp")
  defp detect(_, ~m"0b77"h), do: ok("ac3", "audio/vnd.dolby.dd-raw")
  defp detect(_, ~m"7801"h), do: ok("dmg", "application/x-apple-diskimage")
  defp detect(_, ~m"4d5a"h), do: ok("exe", "application/x-msdownload")
  defp detect(_, ~m"1fa0"h), do: ok("Z", "application/x-compress")
  defp detect(_, ~m"1f9d"h), do: ok("Z", "application/x-compress")

  # 3 bytes
  defp detect(_, ~m"ID3"), do: ok("mp3", "audio/mpeg")
  defp detect(_, ~m"MP+"), do: ok("mpc", "audio/x-musepack")
  defp detect(_, ~m"ffd8ff"h), do: ok("jpg", "image/jpeg")
  defp detect(_, ~m"4949bc"h), do: ok("jxr", "image/vnd.ms-photo")
  defp detect(_, ~m"1f8b"h), do: ok("gz", "application/gzip")
  defp detect(_, ~m"425a68"h), do: ok("bz2", "application/x-bzip2")
  defp detect(_, ~m"435753"h), do: ok("swf", "application/x-shockwave-flash")
  defp detect(_, ~m"465753"h), do: ok("swf", "application/x-shockwave-flash")
  defp detect(_, ~m"474946"h), do: ok("gif", "image/gif")

  # 4 bytes
  defp detect(_, ~m"FLIF"), do: ok("flif", "image/flif")
  defp detect(_, ~m"8BPS"), do: ok("psd", "image/vnd.adobe.photoshop")
  defp detect(_, ~m"icns"), do: ok("icns", "image/icns")
  defp detect(_, ~m"MPCK"), do: ok("mpc", "audio/x-musepack")
  defp detect(_, ~m"FORM"), do: ok("aif", "audio/aiff")
  defp detect(_, ~m"MThd"), do: ok("mid", "audio/midi")
  defp detect(_, ~m"fLaC"), do: ok("flac", "audio/x-flac")
  defp detect(_, ~m"IMPM"), do: ok("it", "audio/x-it")
  defp detect(_, ~m"DSD "), do: ok("dsf", "audio/x-dsf")
  defp detect(_, ~m"wvpk"), do: ok("wv", "audio/wavpack")
  defp detect(_, ~m"MAC "), do: ok("ape", "audio/ape")
  defp detect(_, ~m"%PDF-"), do: ok("pdf", "application/pdf")
  defp detect(_, ~m"LZIP"), do: ok("lz", "application/x-lzip")
  defp detect(_, ~m"SQLi"), do: ok("sqlite", "application/x-sqlite3")
  defp detect(_, ~m"Cr24"), do: ok("crx", "application/x-google-chrome-extension")
  defp detect(_, ~m"MSCF"), do: ok("cab", "application/vnd.ms-cab-compressed")
  defp detect(_, ~m"ISc("), do: ok("cab", "application/vnd.ms-cab-compressed")
  defp detect(_, ~m"1a45dfa3"h), do: ok("mkv", "video/x-matroska")
  defp detect(_, ~m"464c5601"h), do: ok("flv", "video/x-flv")
  defp detect(_, ~m"89504e47"h), do: ok("png", "image/png")
  defp detect(_, ~m"425047fb"h), do: ok("bpg", "image/bpg")
  defp detect(_, ~m"4d4d002a"h), do: ok("tif", "image/tiff")
  defp detect(_, ~m"c5d0d3c6"h), do: ok("eps", "application/eps")
  defp detect(_, ~m"0061736d"h), do: ok("wasm", "application/wasm")
  defp detect(_, ~m"d4c3b2a1"h), do: ok("pcap", "application/vnd.tcpdump.pcap")
  defp detect(_, ~m"a1b2c3d4"h), do: ok("pcap", "application/vnd.tcpdump.pcap")
  defp detect(_, ~m"4e45531a"h), do: ok("nes", "application/x-nintendo-nes-rom")
  defp detect(_, ~m"edabeedb"h), do: ok("rpm", "application/x-rpm")

  # 5 bytes
  defp detect(_, ~m"#!AMR"), do: ok("amr", "audio/amr")
  defp detect(_, ~m"{\rtf"), do: ok("rtf", "application/rtf")
  defp detect(_, ~m"4f54544f00"h), do: ok("otf", "font/otf")
  defp detect(_, ~m"0001000000"h), do: ok("ttf", "font/ttf")

  defp detect(_, ~m"000001ba21"h), do: ok("mpg", "video/MP1S")
  defp detect(_, ~m"000001ba44"h), do: ok("mpg", "video/MP2P")

  # 6 bytes
  defp detect(_, ~m"<?xml "), do: ok("xml", "application/xml")
  defp detect(_, ~m"BEGIN:"), do: ok("ics", "text/calendar")
  defp detect(_, ~m"solid "), do: ok("stl", "model/stl")
  defp detect(_, ~m"fd377a585a00"h), do: ok("xz", "application/x-xz")
  defp detect(_, ~m"526172211a07"h), do: ok("rar", "application/vnd.rar")
  defp detect(_, ~m"377abcaf271c"h), do: ok("7z", "application/x-7z-compressed")

  # 7 bytes
  defp detect(_, ~m"BLENDER"), do: ok("blend", "application/x-blender")
  defp detect(_, ~m"2::-lh0-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh1-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh2-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh3-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh4-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh5-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh6-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lh7-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lzs-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lz4-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lz5-"o), do: ok("lzh", "application/x-lzh-compressed")
  defp detect(_, ~m"2::-lhd-"o), do: ok("lzh", "application/x-lzh-compressed")

  # 8 bytes
  defp detect(_, ~m"4::free"o), do: ok("mov", "video/quicktime")
  defp detect(_, ~m"4::mdat"o), do: ok("mov", "video/quicktime")
  defp detect(_, ~m"4::moov"o), do: ok("mov", "video/quicktime")
  defp detect(_, ~m"4::wide"o), do: ok("mov", "video/quicktime")
  defp detect(_, ~m"wOFFOTTO"), do: ok("woff", "font/woff")
  defp detect(_, ~m"wOF2OTTO"), do: ok("woff2", "font/woff2")
  defp detect(_, ~m"774f464600010000"h), do: ok("woff", "font/woff")
  defp detect(_, ~m"774f463200010000"h), do: ok("woff2", "font/woff2")
  defp detect(_, ~m"4152524f57310000"h), do: ok("arrow", "application/x-apache-arrow")
  defp detect(_, ~m"676c544602000000"h), do: ok("glb", "model/gltf-binary")
  defp detect(_, ~m"4::304d4945"oh), do: ok("mie", "application/x-mie")

  # 9 bytes
  defp detect(_, ~m"4949524f0800000018"h), do: ok("orf", "image/x-olympus-orf")

  # 10 bytes
  defp detect(_, ~m"3026b2758e66cf11a6d9"h), do: ok("asf", "application/vnd.ms-asf")

  # 12 bytes
  defp detect(_, ~m"8::WEBP"o), do: ok("webp", "image/webp")
  defp detect(_, ~m"ab4b5458203131bb0d0a1a0a"h), do: ok("ktx", "image/ktx")
  defp detect(_, ~m"494955001800000088e774d8"h), do: ok("rw2", "image/x-panasonic-rw2")
  defp detect(_, <<"RIFF", _::binary-4, "AVI">> <> _), do: ok("avi", "video/vnd.avi")
  defp detect(_, <<"RIFF", _::binary-4, "WAVE">> <> _), do: ok("wav", "audio/vnd.wave")
  defp detect(_, <<"RIFF", _::binary-4, "QLCM">> <> _), do: ok("qcp", "audio/qcelp")

  defp detect(_, ~m"4::ftyp"o = data) do
    data
    |> binary_part(8, 4)
    |> String.replace("\0", " ")
    |> case do
      "avif" -> ok("avif", "image/avif")
      "mif1" -> ok("heic", "image/heif")
      "msf1" -> ok("heic", "image/heif-sequence")
      "heic" -> ok("heic", "image/heic")
      "heix" -> ok("heic", "image/heic")
      "hevc" -> ok("heic", "image/heic-sequence")
      "hevx" -> ok("heic", "image/heic-sequence")
      "qt  " -> ok("mov", "video/quicktime")
      "M4V " -> ok("m4v", "video/x-m4v")
      "M4A " -> ok("m4a", "audio/x-m4a")
      "M4P " -> ok("m4p", "video/mp4")
      "F4V " -> ok("f4v", "video/mp4")
      "F4P " -> ok("f4p", "video/mp4")
      "M4B " -> ok("m4b", "audio/mp4")
      "F4A " -> ok("f4a", "audio/mp4")
      "F4B " -> ok("f4b", "audio/mp4")
      "mj2s" -> ok("mj2", "video/mj2")
      "mjp2" -> ok("mj2", "video/mj2")
      "crx " -> ok("cr3", "image/x-canon-cr3")
      "3g2" <> _ -> ok("3g2", "video/3gpp2")
      "3g" <> _ -> ok("3gp", "video/3gpp")
      _ -> ok("mp4", "video/mp4")
    end
  end

  # 14 bytes
  defp detect(_, ~m"060e2b34020501010d0102010102"h) do
    ok("mxf", "application/mxf")
  end

  defp detect(_, ~m"2::270a00000000000000000000"oh) do
    ok("shp", "application/x-esri-shape")
  end

  # 15 bytes
  defp detect(_, ~m"FUJIFILMCCD-RAW"), do: ok("raf", "image/x-fujifilm-raf")

  # 16 bytes
  defp detect(_, ~m"Extended Module:"), do: ok("xm", "audio/x-xm")

  defp detect(_, ~m"626f6f6b000000006d61726b00000000"h) do
    ok("alias", "application/x.apple.alias")
  end

  defp detect(_, ~m"0606edf5d81d46e5bd31efe7fe74b71d"h) do
    ok("indd", "application/x-indesign")
  end

  # 19 bytes
  defp detect(_, ~m"Creative Voice File"), do: ok("voc", "audio/x-voc")

  defp detect(_, ~m"%!PS" = data) do
    case data do
      ~m"14:: EPSF-"o -> ok("eps", "application/eps")
      _ -> ok("ps", "application/postscript")
    end
  end

  # 20 bytes

  defp detect(_, ~m"4c0000000114020000000000c000000000000046"h) do
    ok("lnk", "application/x.ms.shortcut")
  end

  # 21 bytes
  defp detect(_, ~m"!<arch>" = data) do
    case binary_part(data, 8, 13) do
      "debian-binary" -> ok("deb", "application/x-deb")
      _ -> ok("ar", "application/x-unix-archive")
    end
  end

  # 24 bytes
  defp detect(_, ~m"49492a00"h = data) do
    case data do
      ~m"8::CR"o -> ok("cr2", "image/x-canon-cr2")
      ~m"8::1c00fe00"oh -> ok("nef", "image/x-nikon-nef")
      ~m"8::1f000b00"oh -> ok("nef", "image/x-nikon-nef")
      ~m"8::2d00fe00"oh -> ok("dng", "image/x-adobe-dng")
      ~m"8::2700fe00"oh -> ok("dng", "image/x-adobe-dng")
      ~m"9::00fe00040001000000010000000301"oh -> ok("arw", "image/x-sony-arw")
      _ -> ok("tif", "image/tiff")
    end
  end

  defp detect(_, ~m"0000000c6a5020200d0a870a"h = data) do
    case binary_part(data, 20, 4) do
      "jp2 " -> ok("jp2", "image/jp2")
      "jpx " -> ok("jpx", "image/jpx")
      "jpm " -> ok("jpm", "image/jpm")
      "mjp2" -> ok("mj2", "image/mj2")
      "mj2s" -> ok("mj2", "image/mj2")
      _ -> nil
    end
  end

  # 27 bytes
  defp detect(_, ~m"-----BEGIN PGP MESSAGE-----") do
    ok("pgp", "application/pgp-encrypted")
  end

  # 32 bytes
  defp detect(_, ~m"fffeff0e53006b0065007400630068005500700020004d006f00640065006c00"h) do
    ok("skp", "application/vnd.sketchup.skp")
  end

  # 36 bytes
  for eot <- [<<0x00, 0x00, 0x01>>, <<0x01, 0x00, 0x02>>, <<0x02, 0x00, 0x02>>] do
    defp detect(_, <<_::binary-8, unquote(eot), _::binary-23, 0x4C, 0x50>> <> _) do
      ok("eot", "application/vnd.ms-fontobject")
    end
  end

  # 40 bytes
  defp detect(_, ~m"OggS" = data) do
    case data do
      ~m"28::4f70757348656164"oh -> ok("opus", "audio/opus")
      ~m"28::53706565782020"oh -> ok("spx", "audio/ogg")
      ~m"28::7f464c4143"oh -> ok("oga", "audio/ogg")
      ~m"28::01766f72626973"oh -> ok("ogg", "audio/ogg")
      ~m"28::807468656f7261"oh -> ok("ogv", "video/ogg")
      ~m"28::01766964656f00"oh -> ok("ogm", "video/ogg")
      _ -> ok("ogx", "application/ogg")
    end
  end

  # These patterns are likely to produce false positives.
  defp detect(_, ~m"0001000000"h), do: ok("ttf", "font/ttf")
  defp detect(_, ~m"00000100"h), do: ok("ico", "image/x-icon")
  defp detect(_, ~m"00000200"h), do: ok("cur", "image/x-icon")

  # These formats need further processing
  defp detect(io, ~m"504b0304"h), do: Zip.detect(io)
  defp detect(io, ~m"d0cf11e0a1b11ae1"h), do: CFB.detect(io)
  defp detect(io, _), do: Fallback.detect(io)
end
