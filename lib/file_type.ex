defmodule FileType do
  alias FileType.Signature

  @required_bytes 265

  @type reason :: File.posix() | :unrecognized

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

  @doc """
  Determine the MIME type from an IO device.

      iex> FileType.from_io(:stdio)
      {:ok, "image/png"}

  """
  @spec from_io(File.io_device()) :: {:ok, binary} | {:error, reason}
  def from_io(device) do
    device
    |> IO.binread(@required_bytes)
    |> Signature.match()
    |> to_result()
  end

  defp from_file(device) do
    from_io(device)
  after
    File.close(device)
  end

  defp to_result(nil), do: {:error, :unrecognized}
  defp to_result(mime), do: {:ok, mime}
end
