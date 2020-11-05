defmodule FileType do
  import FileType.Utils

  alias FileType.Magic
  alias FileType.Zip
  alias FileType.CFB

  @size 262

  @enforce_keys [:ext, :mime]
  defstruct [:ext, :mime]

  @type t :: %__MODULE__{ext: binary, mime: binary}
  @type error :: File.posix() | :unrecognized
  @type result :: {:ok, t} | {:error, error}

  @doc """
  Determines a MIME type from an IO device.

  ## Examples

      iex> {:ok, io} = File.open("file.png", [:read, :binary])
      {:ok, #PID<0.109.0>}

      iex> FileType.from_io(io)
      {:ok, %FileType{ext: "png", mime: "image/png"}}

  """
  @spec from_io(IO.device()) :: result
  def from_io(io) do
    with {:ok, data} <- :file.read(io, @size),
         {:ok, {ext, mime}} <- detect(io, data) do
      {:ok, %__MODULE__{ext: ext, mime: mime}}
    else
      :eof -> {:error, :unrecognized}
      {:error, reason} -> {:error, reason}
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
  @spec from_path(binary) :: result
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

  defp detect(io, ~h"504b0304" <> _) do
    Zip.detect(io)
  end

  defp detect(io, ~h"d0cf11e0a1b11ae1" <> _) do
    CFB.detect(io)
  end

  defp detect(_io, data) do
    case Magic.run(data) do
      nil -> {:error, :unrecognized}
      type -> {:ok, type}
    end
  end
end
