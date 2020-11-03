defmodule FileType.Magic.RegistrationTest do
  use ExUnit.Case

  defmodule Database do
    use FileType.Magic.Registration

    register "a", "a", magic: "a", magic: [4, "a"]
    register Example, magic: "custom"
  end

  test "builds a list of entries" do
    assert Database.entries() == [
             {{"a", "a"}, ["a"]},
             {{"a", "a"}, [4, "a"]},
             {Example, ["custom"]}
           ]
  end
end
