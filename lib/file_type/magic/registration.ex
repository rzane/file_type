defmodule FileType.Magic.Registration do
  @moduledoc false

  alias FileType.Magic

  @type opts :: [{:magic, Magic.magic() | binary()}]

  defmacro __using__(_) do
    quote do
      import FileType.Magic.Registration
      @before_compile FileType.Magic.Registration
      @__magic__ []
    end
  end

  defmacro __before_compile__(_) do
    quote do
      @doc """
      List the files types that are registered in the database.
      """
      @spec entries :: [Magic.t()]
      def entries, do: @__magic__
    end
  end

  @doc """
  Registers a new file type.
  """
  @spec register(Magic.type(), opts()) :: Macro.t()
  defmacro register(type, opts) do
    magic =
      opts
      |> Keyword.get_values(:magic)
      |> Enum.map(&List.wrap/1)
      |> Enum.map(&{type, &1})

    quote do
      @__magic__ @__magic__ ++ unquote(magic)
    end
  end

  @spec register(Magic.ext(), Magic.mime(), opts()) :: Macro.t()
  defmacro register(ext, mime, opts) do
    quote do: register({unquote(ext), unquote(mime)}, unquote(opts))
  end
end
