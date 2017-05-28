# Computer

This is a simulator to demonstrate the implications of blocking computer program execution vs. concurrent and fully parallel execution.

This app shows how the nuance of how concurrency _can_ help, but doesn't always.
**Spoiler Alert:** Any commands with wait time (like IO), will be more efficient in a concurrent environment.

Finally, the app will demonstrate the advantage of being able to run with full parallelism. 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `computer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:computer, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/computer](https://hexdocs.pm/computer).
