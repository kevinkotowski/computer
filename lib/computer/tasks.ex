defmodule Computer.Tasks do
  alias __MODULE__
  alias Computer.Command

  defstruct [:commands]

  @opaque t :: %Tasks{commands: [Command]}

  @spec new() :: t
  def new() do
    %Tasks{commands: nil}
  end

  def push(%Tasks{} = tasks, command) do
    case tasks.commands do
      nil -> %Tasks{tasks | commands: [command] }
      _ -> %Tasks{commands: tasks.commands ++ [command] }
    end
  end

  def pop(%Tasks{} = tasks) do
    [first | rest] = tasks.commands
    {%Tasks{commands: rest}, first}
  end

  def ticks(%Tasks{} = tasks) do
    Enum.reduce tasks.commands, 0, fn(command, acc) ->
      ticks = Command.duration(command)
      ticks + acc
    end
  end
end
