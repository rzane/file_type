defmodule FileType.Magic.ReaderTest do
  use ExUnit.Case

  alias FileType.Magic

  test "get_size/1" do
    assert Magic.get_size(["foo"]) == 3
    assert Magic.get_size(["foo", 1, "bar"]) == 7
    assert Magic.get_size(["foo", 1, 2, "bar"]) == 9
  end

  test "get_locations/1" do
    assert Magic.get_locations(["foo"]) == [{0, 3}]
    assert Magic.get_locations(["foo", 1, "bar"]) == [{0, 3}, {4, 3}]
    assert Magic.get_locations(["foo", 1, 2, "bar"]) == [{0, 3}, {6, 3}]
  end
end
