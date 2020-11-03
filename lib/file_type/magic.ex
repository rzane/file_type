defmodule FileType.Magic do
  @moduledoc false

  alias FileType.Magic.Database
  alias FileType.Magic.Registration

  @size 40

  @type result :: {:ok, {binary(), binary()}} | {:error, FileType.error()}

  @spec detect(IO.device()) :: result()
  def detect(io) do
    case :file.read(io, @size) do
      {:ok, data} ->
        detect(io, data)

      {:error, reason} ->
        {:error, reason}

      :eof ->
        {:error, :unrecognized}
    end
  end

  @spec match_magic(Registration.magic()) :: Macro.t()
  defmacrop match_magic([]) do
    quote do: _
  end

  defmacrop match_magic([part | parts]) when is_integer(part) do
    quote do: <<_::binary-size(unquote(part))>> <> match_magic(unquote(parts))
  end

  defmacrop match_magic([part | parts]) do
    quote do: unquote(part) <> match_magic(unquote(parts))
  end

  @spec detect(IO.device(), binary()) :: result()
  defp detect(io, data)

  for {type, magic} <- Database.entries() do
    if is_tuple(type) do
      defp detect(_io, match_magic(unquote(magic))) do
        {:ok, unquote(type)}
      end
    else
      defp detect(io, match_magic(unquote(magic))) do
        unquote(type).detect(io)
      end
    end
  end

  defp detect(io, _data) do
    FileType.Fallback.detect(io, Database.entries())
  end
end
