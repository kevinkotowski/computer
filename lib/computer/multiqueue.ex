defmodule Computer.Multiqueue do
  alias __MODULE__
  alias Computer.Command

  defstruct [:queues]

  @opaque t :: %Multiqueue{
    queues: [Computer.Queue]
  }

  # @spec new(integer) :: t
  def new(count) do
    %Multiqueue{queues:
      Enum.reduce(1..count, [], fn(_, queues) ->
        queues ++ [Computer.Queue.new()]
      end)
    }
  end

  def push(%Multiqueue{} = multi, [%Command{}|_] = commands) do
    %Multiqueue{queues:
      List.update_at(multi.queues, shortest(multi), fn(queue) ->
        Computer.Queue.append(queue, commands)
      end)
    }
  end

  def pop(%Multiqueue{} = multi) do
    [head | tail] = multi.queues
    {head, command} = Computer.Queue.pop(head)
    queues = tail ++ [head]

    {%Multiqueue{queues: queues}, command}
  end

  def shortest(%Multiqueue{} = multi) do
    shortest = Enum.min_by(Enum.with_index(multi.queues),
      fn({queue, _index}) -> Computer.Queue.peek(queue) end)
    elem(shortest, 1)
  end

  def peek(%Multiqueue{} = multi) do
    Enum.map(multi.queues, fn(queue) -> Computer.Queue.peek(queue) end)
  end
end
