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

        assert {:ok, type} = FileType.from_path(path)
        assert type == %FileType{ext: ext, mime: mime}
      end
    end
  end
end
