defmodule FileType.ID3 do
  use Bitwise

  @size 10

  def detect(io) do
    with {:ok, data} <- :file.pread(io, 0, @size),
         {:ok, offset} <- parse(data),
         {:ok, _} <- :file.position(io, {:cur, offset}) do
      FileType.from_io(io)
    end
  end

  defp parse(<<"ID3", _version::binary-2, _flags::integer-8, size::binary-4>>) do
    {:ok, parse_size(size)}
  end

  defp parse(_), do: :error

  defp parse_size(<<a, b, c, d>>) do
    d + (c <<< 7) + (b <<< 14) + (a <<< 21)
  end
end
