defmodule Benchmark do
  def run(paths) do
    paths
    |> Map.new(&build/1)
    |> Benchee.run(memory_time: 2)
  end

  defp build(path) do
    name = Path.basename(path)
    bench = fn -> FileType.from_path(path) end
    {name, bench}
  end
end

Benchmark.run([
  "test/fixtures/fixture.png",
  "test/fixtures/fixture.docx",
  "test/fixtures/fixture.ppt",
])
