defmodule FileType.Utils do
  @moduledoc false

  @doc """
  Converts a hex-encoded string to binary.
  """
  defmacro sigil_h({:<<>>, _meta, [data]}, []) when is_binary(data) do
    Base.decode16!(data, case: :lower)
  end
end
