defmodule FileType.Macros do
  @moduledoc false

  defmacro text(data, opts \\ []) do
    offset = Keyword.get(opts, :offset)
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacro hex(data, opts \\ []) do
    data = Base.decode16!(data, case: :lower)
    offset = Keyword.get(opts, :offset, 0)
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacro ftyp(data) do
    quote do: <<_::binary-size(4), "ftyp", unquote(data)>> <> _
  end
end
