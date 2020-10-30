defmodule FileTypeTest do
  use FileType.Case

  describe "application/dicom" do
    @tag :pending
    fixture "fixture.dcm", "application/dicom"
  end

  describe "application/epub+zip" do
    @tag :pending
    fixture "fixture.epub", "application/epub+zip"
  end

  describe "application/gzip" do
    fixture "fixture.tar.gz", "application/gzip"
  end

  describe "application/mxf" do
    @tag :pending
    fixture "fixture.mxf", "application/mxf"
  end

  describe "application/octet-stream" do
    @tag :pending
    fixture "fixture-2.doc.cfb", "application/octet-stream"

    @tag :pending
    fixture "fixture-big-endian.mie", "application/octet-stream"

    @tag :pending
    fixture "fixture-little-endian.mie", "application/octet-stream"

    @tag :pending
    fixture "fixture-monkeysaudio.ape", "application/octet-stream"

    @tag :pending
    fixture "fixture-yuv420-8bit.avif", "application/octet-stream"

    @tag :pending
    fixture "fixture.7z", "application/octet-stream"

    @tag :pending
    fixture "fixture.alias", "application/octet-stream"

    @tag :pending
    fixture "fixture.ar", "application/octet-stream"

    @tag :pending
    fixture "fixture.arrow", "application/octet-stream"

    @tag :pending
    fixture "fixture.arw", "application/octet-stream"

    @tag :pending
    fixture "fixture.asar", "application/octet-stream"

    @tag :pending
    fixture "fixture.blend", "application/octet-stream"

    @tag :pending
    fixture "fixture.bpg", "application/octet-stream"

    @tag :pending
    fixture "fixture.cr2", "application/octet-stream"

    @tag :pending
    fixture "fixture.cr3", "application/octet-stream"

    @tag :pending
    fixture "fixture.cur", "application/octet-stream"

    @tag :pending
    fixture "fixture.dmg", "application/octet-stream"

    @tag :pending
    fixture "fixture.dng", "application/octet-stream"

    @tag :pending
    fixture "fixture.doc.cfb", "application/octet-stream"

    @tag :pending
    fixture "fixture.dsf", "application/octet-stream"

    @tag :pending
    fixture "fixture.exe", "application/octet-stream"

    @tag :pending
    fixture "fixture.f4a", "application/octet-stream"

    @tag :pending
    fixture "fixture.f4b", "application/octet-stream"

    @tag :pending
    fixture "fixture.f4p", "application/octet-stream"

    @tag :pending
    fixture "fixture.f4v", "application/octet-stream"

    @tag :pending
    fixture "fixture.flif", "application/octet-stream"

    @tag :pending
    fixture "fixture.icns", "application/octet-stream"

    @tag :pending
    fixture "fixture.indd", "application/octet-stream"

    @tag :pending
    fixture "fixture.it", "application/octet-stream"

    @tag :pending
    fixture "fixture.lnk", "application/octet-stream"

    @tag :pending
    fixture "fixture.lzh", "application/octet-stream"

    @tag :pending
    fixture "fixture.m4b", "application/octet-stream"

    @tag :pending
    fixture "fixture.m4p", "application/octet-stream"

    @tag :pending
    fixture "fixture.mobi", "application/octet-stream"

    @tag :pending
    fixture "fixture.msi.cfb", "application/octet-stream"

    @tag :pending
    fixture "fixture.nef", "application/octet-stream"

    @tag :pending
    fixture "fixture.nes", "application/octet-stream"

    @tag :pending
    fixture "fixture.ogm", "application/octet-stream"

    @tag :pending
    fixture "fixture.orf", "application/octet-stream"

    @tag :pending
    fixture "fixture.ppt.cfb", "application/octet-stream"

    @tag :pending
    fixture "fixture.raf", "application/octet-stream"

    @tag :pending
    fixture "fixture.rw2", "application/octet-stream"

    @tag :pending
    fixture "fixture.tar.Z", "application/octet-stream"

    @tag :pending
    fixture "fixture.tar.lz", "application/octet-stream"

    @tag :pending
    fixture "fixture.voc", "application/octet-stream"

    @tag :pending
    fixture "fixture.wasm", "application/octet-stream"

    @tag :pending
    fixture "fixture.xls.cfb", "application/octet-stream"

    @tag :pending
    fixture "fixture.xm", "application/octet-stream"

    @tag :pending
    fixture "fixture2.arw", "application/octet-stream"

    @tag :pending
    fixture "fixture2.asar", "application/octet-stream"

    @tag :pending
    fixture "fixture2.dng", "application/octet-stream"

    @tag :pending
    fixture "fixture2.nef", "application/octet-stream"

    @tag :pending
    fixture "fixture3.arw", "application/octet-stream"

    @tag :pending
    fixture "fixture3.nef", "application/octet-stream"

    @tag :pending
    fixture "fixture4.arw", "application/octet-stream"

    @tag :pending
    fixture "fixture4.nef", "application/octet-stream"

    @tag :pending
    fixture "fixture5.arw", "application/octet-stream"
  end

  describe "application/ogg" do
    @tag :pending
    fixture "fixture-unknown-ogg.ogx", "application/ogg"
  end

  describe "application/pdf" do
    fixture "fixture.pdf", "application/pdf"
  end

  describe "application/pgp-encrypted" do
    @tag :pending
    fixture "fixture.pgp", "application/pgp-encrypted"
  end

  describe "application/postscript" do
    fixture "fixture.eps", "application/postscript"
    fixture "fixture.ps", "application/postscript"
    fixture "fixture2.eps", "application/postscript"

    @tag :pending
    fixture "fixture.ai", "application/postscript"
  end

  describe "application/rtf" do
    @tag :pending
    fixture "fixture.rtf", "application/rtf"
  end

  describe "application/vnd.adobe.flash.movie" do
    @tag :pending
    fixture "fixture.swf", "application/vnd.adobe.flash.movie"
  end

  describe "application/vnd.debian.binary-package" do
    @tag :pending
    fixture "fixture.deb", "application/vnd.debian.binary-package"
  end

  describe "application/vnd.koan" do
    @tag :pending
    fixture "fixture.skp", "application/vnd.koan"
  end

  describe "application/vnd.mophun.certificate" do
    @tag :pending
    fixture "fixture-sv7.mpc", "application/vnd.mophun.certificate"

    @tag :pending
    fixture "fixture-sv8.mpc", "application/vnd.mophun.certificate"
  end

  describe "application/vnd.ms-asf" do
    @tag :pending
    fixture "fixture.asf", "application/vnd.ms-asf"

    @tag :pending
    fixture "fixture.wma.asf", "application/vnd.ms-asf"

    @tag :pending
    fixture "fixture.wmv.asf", "application/vnd.ms-asf"
  end

  describe "application/vnd.ms-cab-compressed" do
    @tag :pending
    fixture "fixture.cab", "application/vnd.ms-cab-compressed"
  end

  describe "application/vnd.ms-fontobject" do
    @tag :pending
    fixture "fixture-0x20001.eot", "application/vnd.ms-fontobject"

    @tag :pending
    fixture "fixture.eot", "application/vnd.ms-fontobject"
  end

  describe "application/vnd.oasis.opendocument.presentation" do
    @tag :pending
    fixture "fixture.odp", "application/vnd.oasis.opendocument.presentation"
  end

  describe "application/vnd.oasis.opendocument.spreadsheet" do
    @tag :pending
    fixture "fixture.ods", "application/vnd.oasis.opendocument.spreadsheet"
  end

  describe "application/vnd.oasis.opendocument.text" do
    @tag :pending
    fixture "fixture.odt", "application/vnd.oasis.opendocument.text"
  end

  describe "application/vnd.openxmlformats-officedocument.presentationml.presentation" do
    @tag :pending
    fixture(
      "fixture-office365.pptx",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    )

    @tag :pending
    fixture(
      "fixture.pptx",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    )

    @tag :pending
    fixture(
      "fixture2.pptx",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    )
  end

  describe "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" do
    @tag :pending
    fixture(
      "fixture-office365.xlsx",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )

    @tag :pending
    fixture "fixture.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

    @tag :pending
    fixture "fixture2.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end

  describe "application/vnd.openxmlformats-officedocument.wordprocessingml.document" do
    @tag :pending
    fixture(
      "fixture-office365.docx",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    )

    @tag :pending
    fixture(
      "fixture.docx",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    )

    @tag :pending
    fixture(
      "fixture2.docx",
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    )
  end

  describe "application/vnd.rar" do
    fixture "fixture.rar", "application/vnd.rar"
  end

  describe "application/vnd.shp" do
    @tag :pending
    fixture "fixture.shp", "application/vnd.shp"
  end

  describe "application/vnd.sqlite3" do
    @tag :pending
    fixture "fixture.sqlite", "application/vnd.sqlite3"
  end

  describe "application/vnd.tcpdump.pcap" do
    @tag :pending
    fixture "fixture-big-endian.pcap", "application/vnd.tcpdump.pcap"

    @tag :pending
    fixture "fixture-little-endian.pcap", "application/vnd.tcpdump.pcap"
  end

  describe "application/vnd.wv.csp+wbxml" do
    @tag :pending
    fixture "fixture.wv", "application/vnd.wv.csp+wbxml"
  end

  describe "application/x-bzip2" do
    @tag :pending
    fixture "fixture.bz2", "application/x-bzip2"
  end

  describe "application/x-chrome-extension" do
    @tag :pending
    fixture "fixture.crx", "application/x-chrome-extension"
  end

  describe "application/x-rpm" do
    @tag :pending
    fixture "fixture.rpm", "application/x-rpm"
  end

  describe "application/x-tar" do
    fixture "fixture.tar", "application/x-tar"
    fixture "fixture-spaces.tar", "application/x-tar"

    @tag :pending
    fixture "fixture-v7.tar", "application/x-tar"
  end

  describe "application/x-xpinstall" do
    @tag :pending
    fixture "fixture.xpi", "application/x-xpinstall"
  end

  describe "application/x-xz" do
    @tag :pending
    fixture "fixture.tar.xz", "application/x-xz"
  end

  describe "application/zip" do
    fixture "fixture.zip", "application/zip"
  end

  describe "audio/AMR" do
    @tag :pending
    fixture "fixture.amr", "audio/AMR"
  end

  describe "audio/aac" do
    @tag :pending
    fixture "fixture-adts-mpeg2.aac", "audio/aac"

    @tag :pending
    fixture "fixture-adts-mpeg4-2.aac", "audio/aac"

    @tag :pending
    fixture "fixture-adts-mpeg4.aac", "audio/aac"

    @tag :pending
    fixture "fixture-id3v2.aac", "audio/aac"
  end

  describe "audio/midi" do
    @tag :pending
    fixture "fixture.mid", "audio/midi"
  end

  describe "audio/mp4" do
    @tag :pending
    fixture "fixture-babys-songbook.m4b.m4a", "audio/mp4"

    @tag :pending
    fixture "fixture.m4a", "audio/mp4"
  end

  describe "audio/mpeg" do
    @tag :pending
    fixture "fixture-ffe3.mp3", "audio/mpeg"

    @tag :pending
    fixture "fixture-mp2l3.mp3", "audio/mpeg"

    @tag :pending
    fixture "fixture-mpa.mp2", "audio/mpeg"

    @tag :pending
    fixture "fixture.mp1", "audio/mpeg"

    @tag :pending
    fixture "fixture.mp2", "audio/mpeg"

    fixture "fixture.mp3", "audio/mpeg"
  end

  describe "audio/ogg" do
    fixture "fixture.oga", "audio/ogg"
    fixture "fixture.ogg", "audio/ogg"
    fixture "fixture.spx", "audio/ogg"
  end

  describe "audio/opus" do
    fixture "fixture.opus", "audio/opus"
  end

  describe "audio/qcelp" do
    @tag :pending
    fixture "fixture.qcp", "audio/qcelp"
  end

  describe "audio/vnd.dolby.dd-raw" do
    fixture "fixture.ac3", "audio/vnd.dolby.dd-raw"
  end

  describe "audio/x-aiff" do
    @tag :pending
    fixture "fixture.aif", "audio/x-aiff"
  end

  describe "audio/x-flac" do
    @tag :pending
    fixture "fixture-id3v2.flac", "audio/x-flac"

    @tag :pending
    fixture "fixture.flac", "audio/x-flac"
  end

  describe "audio/x-s3m" do
    @tag :pending
    fixture "fixture.s3m", "audio/x-s3m"
  end

  describe "audio/x-wav" do
    fixture "fixture.wav", "audio/x-wav"
  end

  describe "font/otf" do
    @tag :pending
    fixture "fixture.otf", "font/otf"
  end

  describe "font/ttf" do
    @tag :pending
    fixture "fixture.ttf", "font/ttf"
  end

  describe "font/woff" do
    @tag :pending
    fixture "fixture-otto.woff", "font/woff"

    @tag :pending
    fixture "fixture.woff", "font/woff"
  end

  describe "font/woff2" do
    @tag :pending
    fixture "fixture-otto.woff2", "font/woff2"

    @tag :pending
    fixture "fixture.woff2", "font/woff2"
  end

  describe "image/bmp" do
    fixture "fixture.bmp", "image/bmp"
  end

  describe "image/gif" do
    fixture "fixture.gif", "image/gif"
  end

  describe "image/heic" do
    fixture "fixture-heic.heic", "image/heic"
    fixture "fixture-mif1.heic", "image/heic"
  end

  describe "image/heif-sequence" do
    @tag :pending
    fixture "fixture-msf1.heic", "image/heif-sequence"
  end

  describe "image/jp2" do
    @tag :pending
    fixture "fixture.jp2", "image/jp2"
  end

  describe "image/jpeg" do
    fixture "fixture.jpg", "image/jpeg"
  end

  describe "image/jpm" do
    @tag :pending
    fixture "fixture.jpm", "image/jpm"
  end

  describe "image/jpx" do
    @tag :pending
    fixture "fixture.jpx", "image/jpx"
  end

  describe "image/jxr" do
    @tag :pending
    fixture "fixture.jxr", "image/jxr"
  end

  describe "image/ktx" do
    @tag :pending
    fixture "fixture.ktx", "image/ktx"
  end

  describe "image/png" do
    fixture "fixture.png", "image/png"
    fixture "fixture-itxt.png", "image/png"
    fixture "fixture-corrupt.png", "image/png"
  end

  describe "image/tiff" do
    fixture "fixture.tif", "image/tiff"
    fixture "fixture-big-endian.tif", "image/tiff"
    fixture "fixture-little-endian.tif", "image/tiff"
  end

  describe "image/vnd.adobe.photoshop" do
    fixture "fixture.psd", "image/vnd.adobe.photoshop"
  end

  describe "image/vnd.microsoft.icon" do
    @tag :pending
    fixture "fixture.ico", "image/vnd.microsoft.icon"
  end

  describe "image/vnd.mozilla.apng" do
    @tag :pending
    fixture "fixture.apng", "image/vnd.mozilla.apng"
  end

  describe "image/webp" do
    fixture "fixture.webp", "image/webp"
  end

  describe "model/gltf-binary" do
    @tag :pending
    fixture "fixture.glb", "model/gltf-binary"
  end

  describe "model/stl" do
    @tag :pending
    fixture "fixture.stl", "model/stl"
  end

  describe "model/vnd.mts" do
    @tag :pending
    fixture "fixture.mts", "model/vnd.mts"
  end

  describe "text/calendar" do
    @tag :pending
    fixture "fixture.ics", "text/calendar"
  end

  describe "text/xml" do
    @tag :pending
    fixture "fixture.xml", "text/xml"
  end

  describe "video/3gpp" do
    @tag :pending
    fixture "fixture.3gp", "video/3gpp"

    @tag :pending
    fixture "fixture2.3gp", "video/3gpp"
  end

  describe "video/3gpp2" do
    @tag :pending
    fixture "fixture.3g2", "video/3gpp2"
  end

  describe "video/mj2" do
    @tag :pending
    fixture "fixture.mj2", "video/mj2"
  end

  describe "video/mp4" do
    fixture "fixture.mp4", "video/mp4"
    fixture "fixture.m4v", "video/mp4"
    fixture "fixture-imovie.mp4", "video/mp4"
    fixture "fixture-isom.mp4", "video/mp4"
    fixture "fixture-isomv2.mp4", "video/mp4"
    fixture "fixture-mp4v2.mp4", "video/mp4"

    @tag :pending
    fixture "fixture-dash.mp4", "video/mp4"
  end

  describe "video/mpeg" do
    @tag :pending
    fixture "fixture.mpg", "video/mpeg"

    @tag :pending
    fixture "fixture.ps.mpg", "video/mpeg"

    @tag :pending
    fixture "fixture.sub.mpg", "video/mpeg"

    @tag :pending
    fixture "fixture2.mpg", "video/mpeg"
  end

  describe "video/ogg" do
    fixture "fixture.ogv", "video/ogg"
  end

  describe "video/quicktime" do
    fixture "fixture.mov", "video/quicktime"
    fixture "fixture-mjpeg.mov", "video/quicktime"
    fixture "fixture-moov.mov", "video/quicktime"
  end

  describe "video/webm" do
    @tag :pending
    fixture "fixture.webm", "video/webm"
  end

  describe "video/x-flv" do
    @tag :pending
    fixture "fixture.flv", "video/x-flv"
  end

  describe "video/x-matroska" do
    fixture "fixture.mkv", "video/x-matroska"
    fixture "fixture2.mkv", "video/x-matroska"
  end

  describe "video/x-msvideo" do
    @tag :pending
    fixture "fixture.avi", "video/x-msvideo"
  end
end
