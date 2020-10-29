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

  fixture "fixture.mp3", "audio/mpeg"
  fixture "fixture.wav", "audio/x-wav"
  fixture "fixture.oga", "audio/ogg"
  fixture "fixture.ogg", "audio/ogg"
  fixture "fixture.opus", "audio/ogg"
  fixture "fixture.spx", "audio/ogg"

  fixture "fixture.pdf", "application/pdf"
  fixture "fixture.zip", "application/zip"
  fixture "fixture.tar.gz", "application/gzip"
  fixture "fixture.rar", "application/vnd.rar"
  fixture "fixture.tar", "application/x-tar"
end
