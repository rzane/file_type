defmodule FileType.Magic.Registration do
  @moduledoc false

  @type ext :: binary()
  @type mime :: binary()
  @type type :: {ext(), mime()} | module()
  @type magic :: [binary() | non_neg_integer()]
  @type t :: {type(), magic()}
  @type opts :: [{:magic, magic() | binary()}]

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
      @spec entries :: [FileType.Magic.Registration.t()]
      def entries, do: @__magic__
    end
  end

  @doc """
  Registers a new file type.
  """
  @spec register(type(), opts()) :: Macro.t()
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

  @spec register(ext(), mime(), opts()) :: Macro.t()
  defmacro register(ext, mime, opts) do
    quote do: register({unquote(ext), unquote(mime)}, unquote(opts))
  end
end
