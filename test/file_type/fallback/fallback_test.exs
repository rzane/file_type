defmodule FileType.Magic.FallbackTest do
  use ExUnit.Case

  alias FileType.Magic.Fallback

  test "locate/1" do
    assert Fallback.locate(["foo"]) == [{0, 3}]
    assert Fallback.locate(["foo", 1, "bar"]) == [{0, 3}, {4, 3}]
    assert Fallback.locate(["foo", 1, 2, "bar"]) == [{0, 3}, {6, 3}]
  end

  test "sizeof/1" do
    assert Fallback.sizeof(["foo"]) == 3
    assert Fallback.sizeof(["foo", 1, "bar"]) == 7
    assert Fallback.sizeof(["foo", 1, 2, "bar"]) == 9
  end
end
