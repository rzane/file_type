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
        assert FileType.from_path(path) == {:ok, unquote(mime)}
      end
    end
  end
end
