defmodule FileType.Fixture do
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
