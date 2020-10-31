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
        "." <> ext = Path.extname(unquote(filename))
        path = Path.join("test/fixtures", unquote(filename))

        assert {:ok, type} = FileType.from_path(path)
        assert type == %FileType{ext: ext, mime: unquote(mime)}
      end
    end
  end
end
