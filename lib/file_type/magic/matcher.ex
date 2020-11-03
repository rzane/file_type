defmodule FileType.Magic.Matcher do
  alias FileType.Magic
  alias FileType.Magic.Database

  @spec detect(IO.device(), Magic.size()) :: Magic.result()
  def detect(io, size) do
    case :file.read(io, size) do
      {:ok, data} ->
        match(io, data)

      {:error, reason} ->
        {:error, reason}

      :eof ->
        {:error, :unrecognized}
    end
  end

  @spec compile(Magic.sequence()) :: Macro.t()
  defmacrop compile([]) do
    quote do: _
  end

  defmacrop compile([part | parts]) when is_integer(part) do
    quote do: <<_::binary-size(unquote(part))>> <> compile(unquote(parts))
  end

  defmacrop compile([part | parts]) do
    quote do: unquote(part) <> compile(unquote(parts))
  end

  @spec match(IO.device(), binary()) :: Magic.result()
  defp match(io, data)

  for %Magic{type: type, sequence: sequence} <- Database.entries() do
    if is_atom(type) do
      defp match(io, compile(unquote(sequence))) do
        unquote(type).detect(io)
      end
    else
      defp match(_io, compile(unquote(sequence))) do
        {:ok, unquote(type)}
      end
    end
  end

  defp match(_, _), do: {:error, :unrecognized}
end
