defmodule FileType do
  alias FileType.Signature
  alias FileType.Zip
  alias FileType.CFB

  @enforce_keys [:ext, :mime]
  defstruct [:ext, :mime]

  @required_bytes 265

  @type t :: %__MODULE__{ext: binary, mime: binary}
  @type error :: File.posix() | :unrecognized

  @doc """
  Determines a MIME type from an IO device.

  This will read the first #{@required_bytes} bytes from the
  IO device and attempt to determine the file's type.

  If the file looks like a ZIP archive, further processing will
  be performed in order to support formats like Microsoft Word
  and Excel.

  ## Examples

      iex> {:ok, io} = File.open("file.png", [:read, :binary])
      {:ok, #PID<0.109.0>}

      iex> FileType.from_io(io)
      {:ok, %FileType{ext: "png", mime: "image/png"}}

  """
  @spec from_io(IO.device()) :: {:ok, t} | {:error, error}
  def from_io(io) do
    with {:ok, data} <- binread(io, @required_bytes),
         {:ok, type} <- detect(data),
         {:ok, type} <- Zip.postprocess(io, type),
         {:ok, type} <- CFB.postprocess(io, type),
         {ext, mime} <- type do
      {:ok, %__MODULE__{ext: ext, mime: mime}}
    end
  end

  @doc """
  This is the same as `from_io/1`, except that it will open and close
  a file for you.

  ## Examples

      iex> FileType.from_path("file.png")
      {:ok, %FileType{ext: "png", mime: "image/png"}}

      iex> FileType.from_path("does-not-exist.png")
      {:error, :enoent}

  """
  @spec from_path(binary) :: {:ok, t} | {:error, error}
  def from_path(path) when is_binary(path) do
    case File.open(path, [:read, :binary], &from_io/1) do
      {:ok, result} -> result
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Format an error returned by this library.

  ## Examples

      iex> FileType.format_error(:unrecognized)
      "the file did not match any known format"

      iex> FileType.format_error(:enoent)
      "no such file or directory"

  """
  @spec format_error(error) :: binary
  def format_error(:unrecognized) do
    "the file did not match any known format"
  end

  def format_error(other) do
    other |> :file.format_error() |> to_string()
  end

  defp detect(data) do
    case Signature.detect(data) do
      nil -> {:error, :unrecognized}
      type -> {:ok, type}
    end
  end

  defp binread(io, count) do
    case IO.binread(io, count) do
      :eof -> {:error, :eof}
      {:error, reason} -> {:error, reason}
      data -> {:ok, data}
    end
  end
end
