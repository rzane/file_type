defmodule FileType.Magic.RegistrationTest do
  use ExUnit.Case

  alias FileType.Magic

  defmodule Database do
    use Magic.Registration

    @foo "foo"

    register "a", "a", magic: "a", magic: [4, @foo]
    register Example, magic: "custom"
  end

  test "register/2 builds a list of entries" do
    assert Database.entries() == [
             Magic.new({"a", "a"}, ["a"]),
             Magic.new({"a", "a"}, [4, "foo"]),
             Magic.new(Example, ["custom"])
           ]
  end
end
