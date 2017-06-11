defmodule Computer.Processes do
  alias __MODULE__
  alias Computer.Command

  defstruct [:queues]

  @opaque t :: %Processes{
    queues: [Computer.Queue]
  }

  @spec new(integer) :: t
  def new(count) do
    %Processes{queues:
      Enum.reduce(1..count, [], fn(_, queues) ->
        queues ++ [Computer.Queue.new()]
      end)
    }
  end

  def push(%Processes{} = multi, [%Command{}|_] = commands) do
    %Processes{queues:
      List.update_at(multi.queues, shortest(multi), fn(queue) ->
        Computer.Queue.append(queue, commands)
      end)
    }
  end

  def pop(%Processes{} = multi) do
    [head | tail] = multi.queues
    {head, commands} = pop_blocking(head, [])
    queues = tail ++ [head]
    {%Processes{queues: queues}, commands}
  end

  defp pop_blocking(queue, commands) do
    {queue, command} = Computer.Queue.pop(queue)
    case command.sync do
      :block ->
        # {queue, commands ++ [command]}
        commands = commands ++ [command]
        {queue, commands} = pop_blocking(queue, commands)
      _ ->
        {queue, commands ++ [command]}
    end
  end

  def shortest(%Processes{} = multi) do
    shortest = Enum.min_by(Enum.with_index(multi.queues),
      fn({queue, _index}) -> Computer.Queue.peek(queue) end)
    elem(shortest, 1)
  end

  def peek(%Processes{} = multi) do
    Enum.map(multi.queues, fn(queue) -> Computer.Queue.peek(queue) end)
  end
end
