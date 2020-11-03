defmodule FileType.Magic.RegistrationTest do
  use ExUnit.Case

  defmodule Example do
    use FileType.Magic.Registration

    register "a", "a", magic: "a", magic: {4, "a"}
    register Example, magic: "custom"
  end

  test "registers magic" do
    assert Example.__magic__() == [
             %{type: {"a", "a"}, magic: [{0, "a"}]},
             %{type: {"a", "a"}, magic: [{4, "a"}]},
             %{type: Example, magic: [{0, "custom"}]}
           ]
  end
end
