defmodule FileTypeTest do
  use FileType.Case
  doctest FileType

  fixture "fixture.png", "image/png"
  fixture "fixture.jpg", "image/jpeg"
  fixture "fixture.bmp", "image/bmp"
  fixture "fixture.tif", "image/tiff"
  fixture "fixture.webp", "image/webp"
  fixture "fixture-heic.heic", "image/heic"
  fixture "fixture-mif1.heic", "image/heic"

  fixture "fixture.mp4", "video/mp4"
  fixture "fixture.mkv", "video/x-matroska"
  fixture "fixture.mov", "video/quicktime"
  fixture "fixture-mjpeg.mov", "video/quicktime"
  fixture "fixture-moov.mov", "video/quicktime"

  fixture "fixture.mp3", "audio/mpeg"
  fixture "fixture.wav", "audio/x-wav"

  # Compressed
  fixture "fixture.zip", "application/zip"
  fixture "fixture.tar.gz", "application/gzip"
  fixture "fixture.rar", "application/vnd.rar"
  fixture "fixture.tar", "application/x-tar"

  # Microsoft
  fixture "fixture.doc", "application/msword"

  # Adobe
  fixture "fixture.pdf", "application/pdf"
  fixture "fixture.ps", "application/postscript"
  fixture "fixture.eps", "application/postscript"
  fixture "fixture2.eps", "application/postscript"
  fixture "fixture.psd", "application/vnd.adobe.photoshop"

  # OGG
  fixture "fixture.opus", "audio/opus"
  fixture "fixture.oga", "audio/ogg"
  fixture "fixture.ogg", "audio/ogg"
  fixture "fixture.spx", "audio/ogg"
  fixture "fixture.ogv", "video/ogg"
  fixture "fixture.ogm", "video/ogg"
  fixture "fixture-unknown-ogg.ogx", "application/ogg"
end
