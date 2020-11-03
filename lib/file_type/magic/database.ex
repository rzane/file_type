defmodule FileType.Magic.Database do
  @moduledoc false

  use FileType.Magic.Registration

  import FileType.Utils

  @tiff ~h"49492a00"
  @jpeg2000 ~h"0000000c6a5020200d0a870a"

  register "bmp", "image/bmp", magic: "BM"
  register "ac3", "audio/vnd.dolby.dd-raw", magic: ~h"0b77"
  register "dmg", "application/x-apple-diskimage", magic: ~h"7801"
  register "exe", "application/x-msdownload", magic: ~h"4d5a"
  register "Z", "application/x-compress", magic: ~h"1fa0"
  register "Z", "application/x-compress", magic: ~h"1f9d"
  register "mp3", "audio/mpeg", magic: "ID3"
  register "mpc", "audio/x-musepack", magic: "MP+"
  register "jpg", "image/jpeg", magic: ~h"ffd8ff"
  register "jxr", "image/vnd.ms-photo", magic: ~h"4949bc"
  register "gz", "application/gzip", magic: ~h"1f8b"
  register "bz2", "application/x-bzip2", magic: ~h"425a68"
  register "swf", "application/x-shockwave-flash", magic: ~h"435753"
  register "swf", "application/x-shockwave-flash", magic: ~h"465753"
  register "gif", "image/gif", magic: ~h"474946"
  register "flif", "image/flif", magic: "FLIF"
  register "psd", "image/vnd.adobe.photoshop", magic: "8BPS"
  register "icns", "image/icns", magic: "icns"
  register "mpc", "audio/x-musepack", magic: "MPCK"
  register "aif", "audio/aiff", magic: "FORM"
  register "mid", "audio/midi", magic: "MThd"
  register "flac", "audio/x-flac", magic: "fLaC"
  register "it", "audio/x-it", magic: "IMPM"
  register "dsf", "audio/x-dsf", magic: "DSD "
  register "wv", "audio/wavpack", magic: "wvpk"
  register "ape", "audio/ape", magic: "MAC "
  register "pdf", "application/pdf", magic: "%PDF-"
  register "lz", "application/x-lzip", magic: "LZIP"
  register "sqlite", "application/x-sqlite3", magic: "SQLi"
  register "crx", "application/x-google-chrome-extension", magic: "Cr24"
  register "cab", "application/vnd.ms-cab-compressed", magic: "MSCF"
  register "cab", "application/vnd.ms-cab-compressed", magic: "ISc("
  register "mkv", "video/x-matroska", magic: ~h"1a45dfa3"
  register "flv", "video/x-flv", magic: ~h"464c5601"
  register "png", "image/png", magic: ~h"89504e47"
  register "bpg", "image/bpg", magic: ~h"425047fb"
  register "tif", "image/tiff", magic: ~h"4d4d002a"
  register "eps", "application/eps", magic: ~h"c5d0d3c6"
  register "wasm", "application/wasm", magic: ~h"0061736d"
  register "pcap", "application/vnd.tcpdump.pcap", magic: ~h"d4c3b2a1"
  register "pcap", "application/vnd.tcpdump.pcap", magic: ~h"a1b2c3d4"
  register "nes", "application/x-nintendo-nes-rom", magic: ~h"4e45531a"
  register "rpm", "application/x-rpm", magic: ~h"edabeedb"
  register "amr", "audio/amr", magic: "#!AMR"
  register "rtf", "application/rtf", magic: "{\\rtf"
  register "otf", "font/otf", magic: ~h"4f54544f00"
  register "ttf", "font/ttf", magic: ~h"0001000000"
  register "mpg", "video/MP1S", magic: ~h"000001ba21"
  register "mpg", "video/MP2P", magic: ~h"000001ba44"
  register "xml", "application/xml", magic: "<?xml "
  register "ics", "text/calendar", magic: "BEGIN:"
  register "stl", "model/stl", magic: "solid "
  register "xz", "application/x-xz", magic: ~h"fd377a585a00"
  register "rar", "application/vnd.rar", magic: ~h"526172211a07"
  register "7z", "application/x-7z-compressed", magic: ~h"377abcaf271c"
  register "blend", "application/x-blender", magic: "BLENDER"

  register "lzh", "application/x-lzh-compressed",
    magic: [2, "-lh0-"],
    magic: [2, "-lh1-"],
    magic: [2, "-lh2-"],
    magic: [2, "-lh3-"],
    magic: [2, "-lh4-"],
    magic: [2, "-lh5-"],
    magic: [2, "-lh6-"],
    magic: [2, "-lh7-"],
    magic: [2, "-lzs-"],
    magic: [2, "-lz4-"],
    magic: [2, "-lz5-"],
    magic: [2, "-lhd-"]

  register "mov", "video/quicktime",
    magic: [4, "free"],
    magic: [4, "mdat"],
    magic: [4, "moov"],
    magic: [4, "wide"]

  register "woff", "font/woff",
    magic: "wOFFOTTO",
    magic: ~h"774f464600010000"

  register "woff2", "font/woff2",
    magic: "wOF2OTTO",
    magic: ~h"774f463200010000"

  register "arrow", "application/x-apache-arrow", magic: ~h"4152524f57310000"
  register "glb", "model/gltf-binary", magic: ~h"676c544602000000"
  register "mie", "application/x-mie", magic: [4, ~h"304d4945"]
  register "orf", "image/x-olympus-orf", magic: ~h"4949524f0800000018"
  register "asf", "application/vnd.ms-asf", magic: ~h"3026b2758e66cf11a6d9"
  register "webp", "image/webp", magic: [8, "WEBP"]
  register "ktx", "image/ktx", magic: ~h"ab4b5458203131bb0d0a1a0a"
  register "rw2", "image/x-panasonic-rw2", magic: ~h"494955001800000088e774d8"
  register "avi", "video/vnd.avi", magic: ["RIFF", 4, "AVI"]
  register "wav", "audio/vnd.wave", magic: ["RIFF", 4, "WAVE"]
  register "qcp", "audio/qcelp", magic: ["RIFF", 4, "QLCM"]

  register "heic", "image/heic",
    magic: [4, "ftyp", "heic"],
    magic: [4, "ftyp", "heix"]

  register "heic", "image/heic-sequence",
    magic: [4, "ftyp", "hevc"],
    magic: [4, "ftyp", "hevx"]

  register "mj2", "video/mj2",
    magic: [4, "ftyp", "mj2s"],
    magic: [4, "ftyp", "mjp2"]

  register "avif", "image/avif", magic: [4, "ftyp", "avif"]
  register "heic", "image/heif", magic: [4, "ftyp", "mif1"]
  register "heic", "image/heif-sequence", magic: [4, "ftyp", "msf1"]
  register "mov", "video/quicktime", magic: [4, "ftyp", "qt"]
  register "m4v", "video/x-m4v", magic: [4, "ftyp", "M4V"]
  register "m4a", "audio/x-m4a", magic: [4, "ftyp", "M4A"]
  register "m4p", "video/mp4", magic: [4, "ftyp", "M4P"]
  register "f4v", "video/mp4", magic: [4, "ftyp", "F4V"]
  register "f4p", "video/mp4", magic: [4, "ftyp", "F4P"]
  register "m4b", "audio/mp4", magic: [4, "ftyp", "M4B"]
  register "f4a", "audio/mp4", magic: [4, "ftyp", "F4A"]
  register "f4b", "audio/mp4", magic: [4, "ftyp", "F4B"]
  register "cr3", "image/x-canon-cr3", magic: [4, "ftyp", "crx"]
  register "3g2", "video/3gpp2", magic: [4, "ftyp", "3g2"]
  register "3gp", "video/3gpp", magic: [4, "ftyp", "3g"]
  register "mp4", "video/mp4", magic: [4, "ftyp"]
  register "mxf", "application/mxf", magic: ~h"060e2b34020501010d0102010102"
  register "shp", "application/x-esri-shape", magic: [2, ~h"270a00000000000000000000"]
  register "raf", "image/x-fujifilm-raf", magic: "FUJIFILMCCD-RAW"
  register "xm", "audio/x-xm", magic: "Extended Module:"
  register "alias", "application/x.apple.alias", magic: ~h"626f6f6b000000006d61726b00000000"
  register "indd", "application/x-indesign", magic: ~h"0606edf5d81d46e5bd31efe7fe74b71d"
  register "voc", "audio/x-voc", magic: "Creative Voice File"
  register "eps", "application/eps", magic: ["%!PS", 10, " EPSF-"]
  register "ps", "application/postscript", magic: "%!PS"
  register "lnk", "application/x.ms.shortcut", magic: ~h"4c0000000114020000000000c000000000000046"
  register "deb", "application/x-deb", magic: ["!<arch>", 1, "debian-binary"]
  register "ar", "application/x-unix-archive", magic: "!<arch>"
  register "cr2", "image/x-canon-cr2", magic: [@tiff, 4, "CR"]

  register "nef", "image/x-nikon-nef",
    magic: [@tiff, 4, ~h"1c00fe00"],
    magic: [@tiff, 4, ~h"1f000b00"]

  register "dng", "image/x-adobe-dng",
    magic: [@tiff, 4, ~h"2d00fe00"],
    magic: [@tiff, 4, ~h"2700fe00"]

  register "arw", "image/x-sony-arw", magic: [@tiff, 5, ~h"00fe00040001000000010000000301"]
  register "tif", "image/tiff", magic: @tiff

  register "jp2", "image/jp2", magic: [@jpeg2000, 8, "jp2"]
  register "jpx", "image/jpx", magic: [@jpeg2000, 8, "jpx"]
  register "jpm", "image/jpm", magic: [@jpeg2000, 8, "jpm"]
  register "mj2", "image/mj2", magic: [@jpeg2000, 8, "mjp2"], magic: [@jpeg2000, 8, "mj2s"]

  register "pgp", "application/pgp-encrypted", magic: "-----BEGIN PGP MESSAGE-----"

  register "skp", "application/vnd.sketchup.skp",
    magic: ~h"fffeff0e53006b0065007400630068005500700020004d006f00640065006c00"

  register "eot", "application/vnd.ms-fontobject",
    magic: [8, ~h"000001", 23, ~h"4c50"],
    magic: [8, ~h"010002", 23, ~h"4c50"],
    magic: [8, ~h"020002", 23, ~h"4c50"]

  register "opus", "audio/opus", magic: ["OggS", 24, ~h"4f70757348656164"]
  register "spx", "audio/ogg", magic: ["OggS", 24, ~h"53706565782020"]
  register "oga", "audio/ogg", magic: ["OggS", 24, ~h"7f464c4143"]
  register "ogg", "audio/ogg", magic: ["OggS", 24, ~h"01766f72626973"]
  register "ogv", "video/ogg", magic: ["OggS", 24, ~h"807468656f7261"]
  register "ogm", "video/ogg", magic: ["OggS", 24, ~h"01766964656f00"]
  register "ogx", "application/ogg", magic: "OggS"

  # These patterns are likely to produce false positives.
  register "ttf", "font/ttf", magic: ~h"0001000000"
  register "ico", "image/x-icon", magic: ~h"00000100"
  register "cur", "image/x-icon", magic: ~h"00000200"

  register "s3m", "audio/x-s3m", magic: [44, "SCRM"]
  register "mobi", "application/x-mobipocket-ebook", magic: [60, ~h"424f4f4b4d4f4249"]
  register "dcm", "application/dicom", magic: [128, ~h"4449434d"]
  register "mts", "video/mp2t", magic: [4, "G", 191, "G"]

  register "tar", "application/x-tar",
    magic: [257, ~h"757374617200"],
    magic: [257, ~h"7573746172202000"]

  # These formats need further processing
  register FileType.Zip, magic: ~h"504b0304"
  register FileType.CFB, magic: ~h"d0cf11e0a1b11ae1"
end
