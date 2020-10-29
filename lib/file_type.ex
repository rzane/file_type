defmodule FileType do
  import FileType.Definition

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

  @spec from_path(binary) :: {:ok, binary} | {:error, File.posix | :unrecognized}
  def from_path(path) when is_binary(path) do
    with {:ok, file} <- :file.open(path, [:read, :binary]),
         {:ok, data} <- :file.read(file, @minimum_bytes),
         :ok <- :file.close(file),
         do: detect(data)
  end

  @spec detect(binary) :: {:ok, binary} | {:error, :unrecognized}
  for {mime, offset, signature} <- signatures do
    def detect(<<_::binary-size(unquote(offset))>> <> unquote(signature) <> _) do
      {:ok, unquote(mime)}
    end
  end

  ftyp "MSNV", do: "video/mp4"
  ftyp "M4V", do: "video/mp4"
  ftyp "isom", do: "video/mp4"
  ftyp "f4v ", do: "video/mp4"
  ftyp "mp42", do: "video/mp4"
  ftyp "qt", do: "video/quicktime"
  ftyp "heic", do: "image/heic"
  ftyp "heix", do: "image/heic"
  ftyp "mif1", do: "image/heic"

  def detect(_), do: {:error, :unrecognized}
end
