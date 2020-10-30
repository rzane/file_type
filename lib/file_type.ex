defmodule FileType do
  alias FileType.Signature

  @enforce_keys [:ext, :mime]
  defstruct [:ext, :mime]

  @required_bytes 265

  @type t :: %__MODULE__{ext: binary, mime: binary}
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
  @spec from_path(binary) :: {:ok, t} | {:error, reason}
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
  @spec from_io(File.io_device()) :: {:ok, t} | {:error, reason}
  def from_io(device) do
    device
    |> IO.binread(@required_bytes)
    |> Signature.match()
    |> normalize()
  end

  defp from_file(device) do
    from_io(device)
  after
    File.close(device)
  end

  defp normalize(nil), do: {:error, :unrecognized}
  defp normalize({ext, mime}), do: {:ok, %__MODULE__{ext: ext, mime: mime}}
end
