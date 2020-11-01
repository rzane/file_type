defmodule FileType.Utils do
  @moduledoc false

  @doc """
  Creates a binary pattern match on the beginning of a binary.

  ## Modifiers

    * `h`: the data is hex-encoded
    * `o`: the match requires an offset

  ## Examples

      iex> ~m"foo" = "foobar"
      "foobar"

      iex> ~m"4869"h = "Hi"
      "Hi"

      iex> ~m"3::bar"o = "foobar"
      "foobar"

  """
  defmacro sigil_m({:<<>>, _meta, [data]}, opts) when is_binary(data) do
    {offset, data} = if ?o in opts, do: parse_offset(data), else: {0, data}
    data = if ?h in opts, do: hex!(data), else: data
    quote do: <<_::binary-size(unquote(offset)), unquote(data)>> <> _
  end

  @doc """
  Just an alias for `binary-size` within a binary pattern match.
  """
  defmacro binary(size) do
    quote do: binary - size(unquote(size))
  end

  defp hex!(data) do
    Base.decode16!(data, case: :lower)
  end

  defp parse_offset(data) do
    case String.split(data, "::", parts: 2) do
      [offset, data] -> {String.to_integer(offset), data}
      _ -> raise "Expected #{inspect(data)} to contain an offset."
    end
  end
end
