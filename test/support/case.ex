defmodule FileType.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import FileType.Case
    end
  end

  defmacro fixture(filename, mime) do
    quote do
      test unquote(filename) <> " is " <> unquote(mime) do
        path = Path.join("test/fixtures", unquote(filename))
        assert {:ok, data} = FileType.read(path)
        assert FileType.get(data) == unquote(mime)
      end
    end
  end
end
