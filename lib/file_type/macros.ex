defmodule FileType.Macros do
  @moduledoc false

  defmacro sigil_h({:<<>>, _, [data]}, []) do
    Base.decode16!(data, case: :lower)
  end

  defmacro text(data, opts \\ []) do
    offset = Keyword.get(opts, :offset)
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  defmacro ftyp(data) do
    quote do: <<_::binary-size(4), "ftyp", unquote(data)>> <> _
  end
end
