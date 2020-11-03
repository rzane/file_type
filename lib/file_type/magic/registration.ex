defmodule FileType.Magic.Registration do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
      @magic []
    end
  end

  defmacro __before_compile__(_) do
    quote do
      def __magic__, do: @magic
    end
  end

  defmacro register(type, opts) do
    type = Macro.expand(type, __CALLER__)

    magic =
      opts
      |> Keyword.get_values(:magic)
      |> Enum.map(&compile_magic/1)
      |> Enum.map(&%{type: type, magic: &1})
      |> Macro.escape()

    quote do
      @magic @magic ++ unquote(magic)
    end
  end

  defmacro register(ext, mime, opts) do
    quote do: register({unquote(ext), unquote(mime)}, unquote(opts))
  end

  # defp magic_size(magic) do
  #   magic
  #   |> Enum.map(fn {offset, bytes} -> offset + byte_size(bytes) end)
  #   |> Enum.sum()
  # end

  defp compile_magic(magic) when is_binary(magic), do: [{0, magic}]
  defp compile_magic(magic) when is_list(magic), do: Enum.flat_map(magic, &compile_magic/1)

  defp compile_magic({offset, magic}) when is_integer(offset) and is_binary(magic),
    do: [{offset, magic}]
end
