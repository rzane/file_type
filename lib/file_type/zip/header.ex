defmodule FileType.Zip.Header do
  @moduledoc false

  @eocd_size 22
  @eocd_sig <<0x50, 0x4B, 0x05, 0x06>>

  @header_size 46
  @header_sig <<0x50, 0x4B, 0x01, 0x02>>

  @enforce_keys [:name, :size]
  defstruct [:name, :size]

  @type t :: %__MODULE__{name: binary(), size: non_neg_integer()}

  @doc "Move to the position of the first header in the file"
  @spec seek(IO.device()) :: {:ok, non_neg_integer()} | {:error, FileType.error()}
  def seek(io) do
    seek(io, {:eof, -@eocd_size})
  end

  defp seek(io, location) do
    case :file.pread(io, location, @eocd_size) do
      {:ok, <<@eocd_sig, _::binary-size(12), start::little-32, _::binary-2>>} ->
        :file.position(io, start)

      {:ok, data} when byte_size(data) == @eocd_size ->
        seek(io, {:cur, -1})

      {:ok, _} ->
        {:error, :unrecognized}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc "Read a header from the zip file"
  @spec read(IO.device()) :: {:ok, t()} | {:error, FileType.error()} | :eof
  def read(io) do
    with {:ok, data} <- :file.read(io, @header_size) do
      parse(io, data)
    end
  end

  defp parse(
         io,
         <<@header_sig, _::binary-20, size::little-32, name_length::little-16,
           extra_length::little-16, comment_length::little-16, _::binary-12>>
       ) do
    case :file.read(io, name_length + extra_length + comment_length) do
      {:ok, <<name::binary-size(name_length)>> <> _} ->
        {:ok, %__MODULE__{name: name, size: size}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse(_io, <<@eocd_sig>> <> _), do: :eof
  defp parse(_io, _data), do: {:error, :unrecognized}
end
