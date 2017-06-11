defmodule Computer.Queue do
  alias __MODULE__
  alias Computer.Command

  defstruct [:commands]

  @opaque t :: %Queue{commands: [Command]}

  @spec new() :: t
  def new() do
    %Queue{commands: []}
  end

  def append(%Queue{} = queue, [%Command{}|_] = commands) do
    case queue.commands do
      nil -> %Queue{queue | commands: commands }
      _ -> %Queue{commands: queue.commands ++ commands }
    end
  end

  def pop(%Queue{} = queue) do
    case queue.commands do
      [] -> {queue, nil}
      _ ->
        [head | tail] = queue.commands
        {%Queue{commands: tail}, head}
    end
  end

  def peek(%Queue{} = queue) do
    case queue.commands do
      [] -> 0
      _ -> Enum.reduce queue.commands, 0, fn(command, acc) ->
          ticks = Command.duration(command)
          ticks + acc
        end
    end
  end
end
