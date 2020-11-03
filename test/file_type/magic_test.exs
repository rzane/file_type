defmodule FileType.Magic.ReaderTest do
  use ExUnit.Case

  alias FileType.Magic

  test "size_of/1" do
    assert Magic.size_of(["foo"]) == 3
    assert Magic.size_of(["foo", 1, "bar"]) == 7
    assert Magic.size_of(["foo", 1, 2, "bar"]) == 9
  end

  test "location_of/1" do
    assert Magic.location_of(["foo"]) == [{0, 3}]
    assert Magic.location_of(["foo", 1, "bar"]) == [{0, 3}, {4, 3}]
    assert Magic.location_of(["foo", 1, 2, "bar"]) == [{0, 3}, {6, 3}]
  end
end
