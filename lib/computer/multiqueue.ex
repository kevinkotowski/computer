defmodule Computer.Multiqueue do
  alias __MODULE__
  alias Computer.Command

  defstruct [:queues]

  @opaque t :: %Multiqueue{
    queues: [Computer.Queue]
  }

  @spec new(integer) :: t
  def new(count) do
    %Multiqueue{queues:
      Enum.reduce(1..count, [], fn(_, queues) ->
        queues ++ [Computer.Queue.new()]
      end)
    }
  end

  def count(%Multiqueue{} = multi) do
    Enum.count(multi.queues)
  end

  def push(%Multiqueue{} = multi, [%Command{}|_] = commands) do
    %Multiqueue{queues:
      List.update_at(multi.queues, shortest(multi), fn(queue) ->
        Computer.Queue.push(queue, commands)
      end)
    }
  end

  def pop(%Multiqueue{} = multi) do
    [first | rest] = multi.queues
    {first, command} = Computer.Queue.pop(first)
    queues = rest ++ [first]

    {%Multiqueue{queues: queues}, command}
  end

  def shortest(%Multiqueue{} = multi) do
    shortest = Enum.min_by(Enum.with_index(multi.queues),
      fn({queue, _index}) -> Computer.Queue.ticks(queue) end)
    elem(shortest, 1)
  end

  def ticks(%Multiqueue{} = multi) do
    Enum.map(multi.queues, fn(queue) -> Computer.Queue.ticks(queue) end)
  end
end
