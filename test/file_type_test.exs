defmodule FileTypeTest do
  use FileType.Case

  describe "application/dicom" do
    fixture "fixture.dcm"
  end

  describe "application/eps" do
    fixture "fixture.eps"
    fixture "fixture2.eps"
  end

  describe "application/epub+zip" do
    @tag :pending
    fixture "fixture.epub"
  end

  describe "application/gzip" do
    fixture "fixture.tar.gz"
  end

  describe "application/mxf" do
    @tag :pending
    fixture "fixture.mxf"
  end

  describe "application/ogg" do
    fixture "fixture-unknown-ogg.ogx"
  end

  describe "application/pdf" do
    fixture "fixture.pdf"
  end

  describe "application/pgp-encrypted" do
    @tag :pending
    fixture "fixture.pgp"
  end

  describe "application/postscript" do
    fixture "fixture.ps"

    @tag :pending
    fixture "fixture.ai"
  end

  describe "application/rtf" do
    fixture "fixture.rtf"
  end

  describe "application/vnd.ms-cab-compressed" do
    fixture "fixture.cab"
  end

  describe "application/vnd.ms-fontobject" do
    @tag :pending
    fixture "fixture.eot"

    @tag :pending
    fixture "fixture-0x20001.eot"
  end

  describe "application/vnd.oasis.opendocument.presentation" do
    @tag :pending
    fixture "fixture.odp"
  end

  describe "application/vnd.oasis.opendocument.spreadsheet" do
    @tag :pending
    fixture "fixture.ods"
  end

  describe "application/vnd.oasis.opendocument.text" do
    @tag :pending
    fixture "fixture.odt"
  end

  describe "application/vnd.openxmlformats-officedocument.presentationml.presentation" do
    @tag :pending
    fixture "fixture.pptx"

    @tag :pending
    fixture "fixture2.pptx"

    @tag :pending
    fixture "fixture-office365.pptx"
  end

  describe "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" do
    @tag :pending
    fixture "fixture.xlsx"

    @tag :pending
    fixture "fixture2.xlsx"

    @tag :pending
    fixture "fixture-office365.xlsx"
  end

  describe "application/vnd.openxmlformats-officedocument.wordprocessingml.document" do
    @tag :pending
    fixture "fixture.docx"

    @tag :pending
    fixture "fixture2.docx"

    @tag :pending
    fixture "fixture-office365.docx"
  end

  describe "application/vnd.sketchup.skp" do
    @tag :pending
    fixture "fixture.skp"
  end

  describe "application/vnd.rar" do
    fixture "fixture.rar"
  end

  describe "application/vnd.tcpdump.pcap" do
    fixture "fixture-big-endian.pcap"
    fixture "fixture-little-endian.pcap"
  end

  describe "application/wasm" do
    fixture "fixture.wasm"
  end

  describe "application/x-7z-compressed" do
    @tag :pending
    fixture "fixture.7z"
  end

  describe "application/x-apache-arrow" do
    @tag :pending
    fixture "fixture.arrow"
  end

  describe "application/x-apple-diskimage" do
    fixture "fixture.dmg"
  end

  describe "application/x-asar" do
    @tag :pending
    fixture "fixture.asar"

    @tag :pending
    fixture "fixture2.asar"
  end

  describe "application/x-blender" do
    @tag :pending
    fixture "fixture.blend"
  end

  describe "application/x-bzip2" do
    fixture "fixture.bz2"
  end

  describe "application/x-cfb" do
    @tag :pending
    fixture "fixture.doc.cfb"

    @tag :pending
    fixture "fixture.msi.cfb"

    @tag :pending
    fixture "fixture.ppt.cfb"

    @tag :pending
    fixture "fixture.xls.cfb"

    @tag :pending
    fixture "fixture-2.doc.cfb"
  end

  describe "application/x-compress" do
    fixture "fixture.tar.Z"
  end

  describe "application/x-deb" do
    @tag :pending
    fixture "fixture.deb"
  end

  describe "application/x-esri-shape" do
    @tag :pending
    fixture "fixture.shp"
  end

  describe "application/x-google-chrome-extension" do
    fixture "fixture.crx"
  end

  describe "application/x-indesign" do
    @tag :pending
    fixture "fixture.indd"
  end

  describe "application/x-lzh-compressed" do
    @tag :pending
    fixture "fixture.lzh"
  end

  describe "application/x-lzip" do
    fixture "fixture.tar.lz"
  end

  describe "application/x-mie" do
    @tag :pending
    fixture "fixture-big-endian.mie"

    @tag :pending
    fixture "fixture-little-endian.mie"
  end

  describe "application/x-mobipocket-ebook" do
    @tag :pending
    fixture "fixture.mobi"
  end

  describe "application/x-msdownload" do
    fixture "fixture.exe"
  end

  describe "application/x-nintendo-nes-rom" do
    fixture "fixture.nes"
  end

  describe "application/x-rpm" do
    fixture "fixture.rpm"
  end

  describe "application/x-shockwave-flash" do
    @tag :pending
    fixture "fixture.swf"
  end

  describe "application/x-sqlite3" do
    fixture "fixture.sqlite"
  end

  describe "application/x-tar" do
    fixture "fixture.tar"
    fixture "fixture-spaces.tar"

    @tag :pending
    fixture "fixture-v7.tar"
  end

  describe "application/x-unix-archive" do
    @tag :pending
    fixture "fixture.ar"
  end

  describe "application/x-xpinstall" do
    @tag :pending
    fixture "fixture.xpi"
  end

  describe "application/x-xz" do
    fixture "fixture.tar.xz"
  end

  describe "application/x.apple.alias" do
    @tag :pending
    fixture "fixture.alias"
  end

  describe "application/x.ms.shortcut" do
    @tag :pending
    fixture "fixture.lnk"
  end

  describe "application/xml" do
    fixture "fixture.xml"
  end

  describe "application/zip" do
    fixture "fixture.zip"
  end

  describe "audio/aac" do
    @tag :pending
    fixture "fixture-id3v2.aac"

    @tag :pending
    fixture "fixture-adts-mpeg2.aac"

    @tag :pending
    fixture "fixture-adts-mpeg4.aac"

    @tag :pending
    fixture "fixture-adts-mpeg4-2.aac"
  end

  describe "audio/aiff" do
    fixture "fixture.aif"
  end

  describe "audio/amr" do
    fixture "fixture.amr"
  end

  describe "audio/ape" do
    fixture "fixture-monkeysaudio.ape"
  end

  describe "audio/midi" do
    fixture "fixture.mid"
  end

  describe "audio/mp4" do
    fixture "fixture.f4a"
    fixture "fixture.f4b"
    fixture "fixture.m4b"
  end

  describe "audio/mpeg" do
    fixture "fixture.mp3"

    @tag :pending
    fixture "fixture.mp1"

    @tag :pending
    fixture "fixture.mp2"

    @tag :pending
    fixture "fixture-mpa.mp2"

    @tag :pending
    fixture "fixture-ffe3.mp3"

    @tag :pending
    fixture "fixture-mp2l3.mp3"
  end

  describe "audio/ogg" do
    fixture "fixture.oga"
    fixture "fixture.ogg"
    fixture "fixture.spx"
  end

  describe "audio/opus" do
    fixture "fixture.opus"
  end

  describe "audio/qcelp" do
    fixture "fixture.qcp"
  end

  describe "audio/vnd.dolby.dd-raw" do
    fixture "fixture.ac3"
  end

  describe "audio/vnd.wave" do
    fixture "fixture.wav"
  end

  describe "audio/wavpack" do
    fixture "fixture.wv"
  end

  describe "audio/x-dsf" do
    fixture "fixture.dsf"
  end

  describe "audio/x-flac" do
    fixture "fixture.flac"

    @tag :pending
    fixture "fixture-id3v2.flac"
  end

  describe "audio/x-it" do
    fixture "fixture.it"
  end

  describe "audio/x-m4a" do
    fixture "fixture.m4a"
    fixture "fixture-babys-songbook.m4b.m4a"
  end

  describe "audio/x-ms-asf" do
    @tag :pending
    fixture "fixture.asf"

    @tag :pending
    fixture "fixture.wma.asf"
  end

  describe "audio/x-musepack" do
    fixture "fixture-sv7.mpc"
    fixture "fixture-sv8.mpc"
  end

  describe "audio/x-s3m" do
    fixture "fixture.s3m"
  end

  describe "audio/x-voc" do
    @tag :pending
    fixture "fixture.voc"
  end

  describe "audio/x-xm" do
    @tag :pending
    fixture "fixture.xm"
  end

  describe "font/otf" do
    fixture "fixture.otf"
  end

  describe "font/ttf" do
    @tag :pending
    fixture "fixture.ttf"
  end

  describe "font/woff" do
    fixture "fixture.woff"
    fixture "fixture-otto.woff"
  end

  describe "font/woff2" do
    fixture "fixture.woff2"
    fixture "fixture-otto.woff2"
  end

  describe "image/apng" do
    @tag :pending
    fixture "fixture.apng"
  end

  describe "image/avif" do
    @tag :pending
    fixture "fixture-yuv420-8bit.avif"
  end

  describe "image/bmp" do
    fixture "fixture.bmp"
  end

  describe "image/bpg" do
    fixture "fixture.bpg"
  end

  describe "image/flif" do
    fixture "fixture.flif"
  end

  describe "image/gif" do
    fixture "fixture.gif"
  end

  describe "image/heic" do
    fixture "fixture-heic.heic"
  end

  describe "image/heif" do
    fixture "fixture-mif1.heic"
  end

  describe "image/heif-sequence" do
    fixture "fixture-msf1.heic"
  end

  describe "image/icns" do
    fixture "fixture.icns"
  end

  describe "image/jp2" do
    @tag :pending
    fixture "fixture.jp2"
  end

  describe "image/jpeg" do
    fixture "fixture.jpg"
  end

  describe "image/jpm" do
    @tag :pending
    fixture "fixture.jpm"
  end

  describe "image/jpx" do
    @tag :pending
    fixture "fixture.jpx"
  end

  describe "image/ktx" do
    @tag :pending
    fixture "fixture.ktx"
  end

  describe "image/mj2" do
    @tag :pending
    fixture "fixture.mj2"
  end

  describe "image/png" do
    fixture "fixture.png"
    fixture "fixture-itxt.png"

    # FIXME: This should not be recognized as a PNG?
    fixture "fixture-corrupt.png"
  end

  describe "image/tiff" do
    fixture "fixture.tif"
    fixture "fixture-big-endian.tif"
    fixture "fixture-little-endian.tif"
  end

  describe "image/vnd.adobe.photoshop" do
    fixture "fixture.psd"
  end

  describe "image/vnd.ms-photo" do
    fixture "fixture.jxr"
  end

  describe "image/webp" do
    fixture "fixture.webp"
  end

  describe "image/x-adobe-dng" do
    fixture "fixture.dng"
    fixture "fixture2.dng"
  end

  describe "image/x-canon-cr2" do
    fixture "fixture.cr2"
  end

  describe "image/x-canon-cr3" do
    fixture "fixture.cr3"
  end

  describe "image/x-fujifilm-raf" do
    @tag :pending
    fixture "fixture.raf"
  end

  describe "image/x-icon" do
    fixture "fixture.ico"
    fixture "fixture.cur"
  end

  describe "image/x-nikon-nef" do
    fixture "fixture.nef"
    fixture "fixture2.nef"
    fixture "fixture3.nef"
    fixture "fixture4.nef"
  end

  describe "image/x-olympus-orf" do
    @tag :pending
    fixture "fixture.orf"
  end

  describe "image/x-panasonic-rw2" do
    @tag :pending
    fixture "fixture.rw2"
  end

  describe "image/x-sony-arw" do
    fixture "fixture.arw"
    fixture "fixture2.arw"
    fixture "fixture3.arw"
    fixture "fixture4.arw"
    fixture "fixture5.arw"
  end

  describe "model/gltf-binary" do
    @tag :pending
    fixture "fixture.glb"
  end

  describe "model/stl" do
    @tag :pending
    fixture "fixture.stl"
  end

  describe "text/calendar" do
    fixture "fixture.ics"
  end

  describe "video/3gpp" do
    fixture "fixture.3gp"
    fixture "fixture2.3gp"
  end

  describe "video/3gpp2" do
    fixture "fixture.3g2"
  end

  describe "video/MP1S" do
    @tag :pending
    fixture "fixture.ps.mpg"
  end

  describe "video/MP2P" do
    @tag :pending
    fixture "fixture.sub.mpg"
  end

  describe "video/mp2t" do
    @tag :pending
    fixture "fixture.mts"
  end

  describe "video/mp4" do
    fixture "fixture.f4p"
    fixture "fixture.f4v"
    fixture "fixture.m4p"
    fixture "fixture-dash.mp4"
    fixture "fixture-isom.mp4"
    fixture "fixture-mp4v2.mp4"
    fixture "fixture-imovie.mp4"
    fixture "fixture-isomv2.mp4"
  end

  describe "video/mpeg" do
    @tag :pending
    fixture "fixture.mpg"

    @tag :pending
    fixture "fixture2.mpg"
  end

  describe "video/ogg" do
    fixture "fixture.ogm"
    fixture "fixture.ogv"
  end

  describe "video/quicktime" do
    fixture "fixture.mov"
    fixture "fixture-moov.mov"
    fixture "fixture-mjpeg.mov"
  end

  describe "video/vnd.avi" do
    fixture "fixture.avi"
  end

  describe "video/webm" do
    @tag :pending
    fixture "fixture.webm"
  end

  describe "video/x-flv" do
    fixture "fixture.flv"
  end

  describe "video/x-m4v" do
    fixture "fixture.m4v"
  end

  describe "video/x-matroska" do
    fixture "fixture.mkv"
    fixture "fixture2.mkv"
  end

  describe "video/x-ms-asf" do
    @tag :pending
    fixture "fixture.wmv.asf"
  end
end
