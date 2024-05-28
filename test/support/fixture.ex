defmodule FileType.Fixture do
  defmacro fixture(filename) do
    quote do
      test unquote(filename <> " from path"), %{describe: mime} do
        "." <> ext = Path.extname(unquote(filename))
        path = Path.join("test/fixtures", unquote(filename))
        assert {:ok, {ext, mime}} = FileType.from_path(path)
      end


      test unquote(filename <> " from binary"), %{describe: mime} do
        "." <> ext = Path.extname(unquote(filename))
        path = Path.join("test/fixtures", unquote(filename))
        file = File.open!(path)
        contents = IO.binread(file, 2_000_000)
        assert {:ok, {ext, mime}} = FileType.from_binary(contents)
      end
    end
  end
end
