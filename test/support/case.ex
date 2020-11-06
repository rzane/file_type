defmodule FileType.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import FileType.Case
    end
  end

  defmacro fixture(filename) do
    quote do
      test unquote(filename), %{describe: mime} do
        "." <> ext = Path.extname(unquote(filename))
        path = Path.join("test/fixtures", unquote(filename))
        assert {:ok, {ext, mime}} = FileType.from_path(path)
      end
    end
  end
end
