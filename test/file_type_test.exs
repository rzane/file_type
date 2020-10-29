defmodule FileTypeTest do
  use FileType.Case
  doctest FileType

  fixture "fixture.png", "image/png"
  fixture "fixture.jpg", "image/jpeg"
  fixture "fixture.bmp", "image/bmp"
  fixture "fixture.webp", "image/webp"
  fixture "fixture.mp4", "video/mp4"
  fixture "fixture.mkv", "video/x-matroska"
  fixture "fixture.mp3", "audio/mpeg"
  fixture "fixture.pdf", "application/pdf"
  fixture "fixture.zip", "application/zip"
  fixture "fixture.tar.gz", "application/gzip"
  fixture "fixture.rar", "application/vnd.rar"
  fixture "fixture.tar", "application/x-tar"
end
