defmodule Computer.Queue do
  alias __MODULE__
  alias Computer.Command

  defstruct [:commands]

  @opaque t :: %Queue{commands: [Command]}

  @spec new() :: t
  def new() do
    %Queue{commands: nil}
  end

  def push(%Queue{} = queue, command) do
    case queue.commands do
      nil -> %Queue{queue | commands: [command] }
      _ -> %Queue{commands: queue.commands ++ [command] }
    end
  end

  def pop(%Queue{} = queue) do
    [first | rest] = queue.commands
    {%Queue{commands: rest}, first}
  end

  def ticks(%Queue{} = queue) do
    case queue.commands do
      nil -> 0
      _ -> Enum.reduce queue.commands, 0, fn(command, acc) ->
        ticks = Command.duration(command)
        ticks + acc
      end
    end
  end
end
