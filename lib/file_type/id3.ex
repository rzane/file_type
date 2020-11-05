defmodule FileType.ID3 do
  @moduledoc false

  import Bitwise

  @header_size 10

  @doc """
  ID3V2 tags begin at the start of a file and cause detection to fail.

  Here, we'll parse the ID3 tag and learn the position where the contents
  of the file actually begin. Multiple file formats support ID3V2.
  """
  @spec position(binary()) :: non_neg_integer()
  def position(<<"ID3", _version::binary-2, _flags::integer-8, size::binary-4>> <> _) do
    @header_size + parse_size(size)
  end

  def position(_data) do
    0
  end

  defp parse_size(<<a, b, c, d>>) do
    d + bsl(c, 7) + bsl(b, 14) + bsl(a, 21)
  end
end
