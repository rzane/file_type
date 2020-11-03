defmodule FileType.UtilsTest do
  use ExUnit.Case
  import FileType.Utils

  doctest FileType.Utils

  test "~h converts hex to binary" do
    assert ~h"6869" == "hi"
    assert ~h"0102" == <<1, 2>>
  end
end
