defmodule FileTypeTest do
  use ExUnit.Case, async: true

  describe "from_path/1" do
    @empty "test/fixtures/fixture-empty.txt"
    @enoent "test/fixtures/does-not-exist.txt"

    test "returns file errors" do
      assert {:error, :enoent} = FileType.from_path(@enoent)
    end

    test "does not recognize empty file" do
      assert {:error, :unrecognized} = FileType.from_path(@empty)
    end
  end

  describe "format_error/1" do
    test "formats :unrecognized" do
      assert FileType.format_error(:unrecognized) == "does not match any known format"
    end

    test "formats :enoent" do
      assert FileType.format_error(:enoent) == "no such file or directory"
    end
  end
end
