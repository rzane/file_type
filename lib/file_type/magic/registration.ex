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
    quote do
      entries =
        unquote(opts)
        |> Keyword.get_values(:magic)
        |> Enum.map(&List.wrap/1)
        |> Enum.map(&FileType.Magic.new(unquote(type), &1))

      @__magic__ @__magic__ ++ entries
    end
  end

  @spec register(Magic.ext(), Magic.mime(), opts()) :: Macro.t()
  defmacro register(ext, mime, opts) do
    quote do: register({unquote(ext), unquote(mime)}, unquote(opts))
  end
end
