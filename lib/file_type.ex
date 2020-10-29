defmodule FileType do
  import FileType.Macros

  @minimum_bytes 4_100

  signature_file = Application.app_dir(:file_type, "priv/supported.txt")

  signatures =
    signature_file
    |> File.stream!()
    |> Enum.reject(&String.starts_with?(&1, ["#", "\n"]))
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [mime, offset, signature] ->
      offset = String.to_integer(offset)
      signature = Base.decode16!(signature, case: :lower)
      {mime, offset, signature}
    end)

  @external_resource signature_file

  @spec from_path(binary) :: {:ok, binary} | {:error, File.posix() | :unrecognized}
  def from_path(path) when is_binary(path) do
    with {:ok, file} <- :file.open(path, [:read, :binary]),
         {:ok, data} <- :file.read(file, @minimum_bytes),
         :ok <- :file.close(file) do
      case detect(data) do
        nil -> {:error, :unrecognized}
        mime -> {:ok, mime}
      end
    end
  end

  @spec detect(binary) :: binary | nil

  for {mime, offset, signature} <- signatures do
    def detect(<<_::binary-size(unquote(offset))>> <> unquote(signature) <> _) do
      unquote(mime)
    end
  end

  def detect(ftyp("MSNV")), do: "video/mp4"
  def detect(ftyp("M4V")), do: "video/mp4"
  def detect(ftyp("isom")), do: "video/mp4"
  def detect(ftyp("f4v ")), do: "video/mp4"
  def detect(ftyp("mp42")), do: "video/mp4"
  def detect(ftyp("qt")), do: "video/quicktime"
  def detect(ftyp("heic")), do: "image/heic"
  def detect(ftyp("heix")), do: "image/heic"
  def detect(ftyp("mif1")), do: "image/heic"

  def detect("OggS" <> _ = data) do
    case data do
      text("OpusHead", offset: 28) ->"audio/opus"
      hex("807468656f7261", offset: 28) -> "video/ogg"
      hex("01766964656f00", offset: 28) -> "video/ogg"
      text("Speex", offset: 28) -> "audio/ogg"
      text("\dFLAC", offset: 28) -> "audio/ogg"
      hex("01766f72626973", offset: 28) -> "audio/ogg"
      _ -> "application/ogg"
    end
  end

  def detect(_), do: nil
end
