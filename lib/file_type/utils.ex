defmodule FileType.Utils.Hex do
  @moduledoc false

  @doc """
  Converts a hex-encoded string to binary.

  ## Examples

      iex> ~h"68656c6c6f"
      "hello"

      iex> ~h"0001"
      <<0x00, 0x01>>

  """
  defmacro sigil_h({:<<>>, _meta, [data]}, []) when is_binary(data) do
    Base.decode16!(data, case: :lower)
  end
end
