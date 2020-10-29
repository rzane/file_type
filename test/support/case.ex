defmodule FileType.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import FileType.Case
    end
  end

  defmacro fixture(filename, mime) do
    quote do
      test unquote(filename) do
        assert_mime unquote(filename), unquote(mime)
      end
    end
  end

  def assert_mime(filename, mime) do
    path = Path.join("test/fixtures", filename)
    assert {:ok, content} = FileType.read(path)
    assert FileType.detect(content) == mime
  end
end
