defmodule FileType.MixProject do
  use Mix.Project

  @source_url "https://github.com/rzane/file_type"
  @version "0.0.0"

  def project do
    [
      app: :file_type,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      docs: docs(),
      dialyzer: dialyzer(),
      package: package(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  defp aliases do
    [benchmark: ["run benchmark.exs"]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp dialyzer do
    [plt_file: {:no_warn, "priv/plts/dialyzer.plt"}]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0", only: :dev},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp package do
    [
      description: "Detect the MIME type of a file based on it's content.",
      maintainers: ["Ray Zane"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end
end
