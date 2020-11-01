defmodule FileType.Zip.HeaderTest do
  use ExUnit.Case

  alias FileType.Zip.Header

  setup context do
    if path = context[:io] do
      open(path)
    else
      :ok
    end
  end

  @tag io: "test/fixtures/fixture.zip"
  test "reads each header from a valid zip file", %{io: io} do
    assert {:ok, 54479} = Header.seek(io)

    assert {:ok, a} = Header.read(io)
    assert a.name == "a.txt"
    assert a.size == 25

    assert {:ok, b} = Header.read(io)
    assert b.name == "b.png"
    assert b.size == 54318

    assert :eof = Header.read(io)
  after
  end

  @tag io: "test/fixtures/fixture.png"
  test "detects that the file is not valid", %{io: io} do
    assert {:error, :unrecognized} = Header.seek(io)
  end

  defp open(path) do
    io = File.open!(path, [:read, :binary])
    on_exit(fn -> File.close(io) end)
    [io: io]
  end
end
