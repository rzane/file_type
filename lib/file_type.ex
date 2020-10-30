defmodule FileType do
  @required_bytes 265

  @type reason :: File.posix() | :unrecognized

  defmacrop sigil_h({:<<>>, _, [data]}, []) do
    Base.decode16!(data, case: :lower)
  end

  defmacrop magic(data, offset \\ 0) do
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacrop ftyp(data) do
    quote do: <<_::binary-size(4), "ftyp", unquote(data)>> <> _
  end

  @doc """
  Determine the MIME type of a file on disk.

  ## Examples

      iex> FileType.from_path("file.png")
      {:ok, "image/png"}

      iex> FileType.from_path("file.abc")
      {:error, :unrecognized}

      iex> FileType.from_path("does-not-exist.txt")
      {:error, :enoexist}

  """
  @spec from_path(binary) :: {:ok, binary} | {:error, reason}
  def from_path(path) when is_binary(path) do
    with {:ok, file} <- File.open(path, [:read, :binary]) do
      from_file(file)
    end
  end

  @spec from_io(File.io_device()) :: {:ok, binary} | {:error, reason}
  def from_io(device) do
    device
    |> IO.binread(@required_bytes)
    |> match()
    |> to_result()
  end

  defp from_file(device) do
    from_io(device)
  after
    File.close(device)
  end

  defp to_result(nil), do: {:error, :unrecognized}
  defp to_result(mime), do: {:ok, mime}

  @spec match(binary) :: binary | nil

  # 2-byte signatures
  defp match(magic("BM")), do: "image/bmp"
  defp match(magic(~h"0b77")), do: "audio/vnd.dolby.dd-raw"
  defp match(magic(~h"7801")), do: "application/x-apple-diskimage"
  defp match(magic(~h"4d5a")), do: "application/x-msdownload"
  defp match(magic(~h"1fa0")), do: "application/x-compress"
  defp match(magic(~h"1f9d")), do: "application/x-compress"

  # 3-byte signatures
  defp match(magic("ID3")), do: "audio/mpeg" # FIXME: file-type does a bit more work
  defp match(magic(~h"ffd8ff")), do: "image/jpeg"
  defp match(magic(~h"4949bc")), do: "image/vnd.ms-photo"
  defp match(magic(~h"1f8b")), do: "application/gzip"
  defp match(magic(~h"425a68")), do: "application/x-bzip2"
  defp match(magic(~h"435753")), do: "application/x-shockwave-flash"
  defp match(magic(~h"465753")), do: "application/x-shockwave-flash"

  # 4-byte signatures
  defp match(magic(~h"474946")), do: "image/gif"
  defp match(magic("FLIF")), do: "image/flif"
  defp match(magic("8BPS")), do: "image/vnd.adobe.photoshop"
  defp match(magic("WEBP", 8)), do: "image/webp"
  defp match(magic("free", 4)), do: "video/quicktime"
  defp match(magic("mdat", 4)), do: "video/quicktime"
  defp match(magic("moov", 4)), do: "video/quicktime"
  defp match(magic("wide", 4)), do: "video/quicktime"
  defp match(magic("WAVE", 8)), do: "audio/vnd.wave"
  defp match(magic("%PDF-")), do: "application/pdf" # FIXME: Adobe Illustrator
  defp match(magic("Rar!")), do: "application/vnd.rar"

  defp match(magic("OggS") = data) do
    case data do
       magic("OpusHead", 28) -> "audio/opus"
       magic("Speex", 28) -> "audio/ogg"
       magic("\dFLAC", 28) -> "audio/ogg"
       magic(~h"01766f72626973", 28) -> "audio/ogg"
       magic(~h"807468656f7261", 28) -> "video/ogg"
       magic(~h"01766964656f00", 28) -> "video/ogg"
      _ -> "application/ogg"
    end
  end

  # Postscript
  # FIXME: Some EPS files not matching?
  defp match(magic("%!PS") = data) do
    case data do
      magic(" EPSF-", 14) -> "application/eps"
      _ -> "application/postscript"
    end
  end

  # 8-byte signatures
  defp match(magic(~h"1a45dfa3")), do: "video/x-matroska"
  defp match(magic(~h"89504e47")), do: "image/png"
  defp match(magic(~h"49492a00")), do: "image/tiff"
  defp match(magic(~h"4d4d002a")), do: "image/tiff"
  defp match(magic(~h"504b0304")), do: "application/zip"

  # File-type boxes
  defp match(ftyp("heic")), do: "image/heic"
  defp match(ftyp("heix")), do: "image/heic"
  defp match(ftyp("mif1")), do: "image/heic"
  defp match(ftyp("MSNV")), do: "video/mp4"
  defp match(ftyp("M4V")), do: "video/mp4"
  defp match(ftyp("isom")), do: "video/mp4"
  defp match(ftyp("f4v ")), do: "video/mp4"
  defp match(ftyp("mp42")), do: "video/mp4"
  defp match(ftyp("qt")), do: "video/quicktime"

  # More bytes!
  defp match(magic(~h"757374617200", 257)), do: "application/x-tar"
  defp match(magic(~h"7573746172202000", 257)), do: "application/x-tar"

  defp match(_), do: nil
end
