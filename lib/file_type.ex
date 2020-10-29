defmodule FileType do
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

  def detect(_), do: {:error, :unrecognized}
end
