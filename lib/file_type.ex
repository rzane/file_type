defmodule FileType do
  alias FileType.Signature
  alias FileType.Zip

  @enforce_keys [:ext, :mime]
  defstruct [:ext, :mime]

  @required_bytes 265

  @type t :: %__MODULE__{ext: binary, mime: binary}

  @doc """
  Determine the MIME type of a file on disk.

  This will read the first #{@required_bytes} bytes from the
  file and attempt to determine the file's type.

  ## Examples

      iex> FileType.from_path("file.png")
      {:ok, "image/png"}

      iex> FileType.from_path("file.abc")
      {:error, :unrecognized}

      iex> FileType.from_path("does-not-exist.txt")
      {:error, :enoexist}

  """
  @spec from_path(binary) :: {:ok, t} | {:error, File.posix() | :unrecognized}
  def from_path(path) when is_binary(path) do
    with {:ok, file} <- File.open(path, [:read, :binary]) do
      from_file(file)
    end
  end

  @doc """
  Determine the MIME type from an IO device.

  This will read the first #{@required_bytes} bytes from the
  IO device and attempt to determine the file's type.

      iex> {:ok, file} = File.open("file.png", [:read, :binary])
      {:ok, #PID<0.109.0>}

      iex> FileType.from_io(file)
      {:ok, "image/png"}

  """
  @spec from_io(IO.device()) :: {:ok, t} | {:error, :unrecognized}
  def from_io(io) do
    with {:ok, data} <- binread(io, @required_bytes) do
      data
      |> Signature.detect()
      |> Zip.postprocess(io)
      |> normalize()
    end
  end

  defp from_file(io) do
    from_io(io)
  after
    File.close(io)
  end

  defp normalize({ext, mime}) do
    {:ok, %__MODULE__{ext: ext, mime: mime}}
  end

  defp normalize(nil) do
    {:error, :unrecognized}
  end

  defp binread(io, count) do
    case IO.binread(io, count) do
      :eof -> {:error, :eof}
      {:error, reason} -> {:error, reason}
      data -> {:ok, data}
    end
  end
end
