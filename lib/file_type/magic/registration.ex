defmodule FileType.Magic.Registration do
  @moduledoc false

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
    magic =
      opts
      |> Keyword.get_values(:magic)
      |> Enum.map(&List.wrap/1)
      |> Enum.map(&{type, &1})

    quote do
      @magic @magic ++ unquote(magic)
    end
  end

  defmacro register(ext, mime, opts) do
    quote do: register({unquote(ext), unquote(mime)}, unquote(opts))
  end

  defmacro match_magic([]) do
    quote do: _
  end

  defmacro match_magic([part | parts]) when is_integer(part) do
    quote do: <<_::binary-size(unquote(part))>> <> match_magic(unquote(parts))
  end

  defmacro match_magic([part | parts]) do
    quote do: unquote(part) <> match_magic(unquote(parts))
  end
end
