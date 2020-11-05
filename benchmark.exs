defmodule Benchmark do
  def run(paths) do
    paths
    |> Map.new(&build/1)
    |> Benchee.run(memory_time: 3)
  end

  defp build(path) do
    name = Path.basename(path)
    run = fn -> FileType.from_path(path) end
    {name, run}
  end
end

Benchmark.run([
  "test/fixtures/fixture.doc",
  "test/fixtures/fixture.docx",
  "test/fixtures/fixture.pdf",
  "test/fixtures/fixture.png",
  "test/fixtures/fixture.tar"
])
