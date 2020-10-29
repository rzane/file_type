defmodule FileType.Definition do
  @moduledoc false

  defmacro ftyp(name, [do: mime]) do
    quote do
      def detect(<<_::binary-size(4), "ftyp", unquote(name)>> <> _) do
        {:ok, unquote(mime)}
      end
    end
  end
end
