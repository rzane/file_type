defmodule FileTypeTest do
  use FileType.Case
  doctest FileType

  fixture "fixture.png", "image/png"
  fixture "fixture.jpg", "image/jpeg"
  fixture "fixture.bmp", "image/bmp"
  fixture "fixture.mp4", "video/mp4"
  fixture "fixture.mkv", "video/x-matroska"
  fixture "fixture.mp3", "audio/mpeg"
end
