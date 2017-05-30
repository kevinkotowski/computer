defmodule Computer.Multiqueue do
  alias __MODULE__
  alias Computer.Cpu
  alias Computer.Command

  defstruct [:queues]

  @opaque t :: %Multiqueue{
    queues: [Computer.Queue]
  }

  @spec new(integer) :: t
  def new(count) do
    range = 1..count
    %Multiqueue{queues:
      Enum.reduce(range, [], fn(_, queues) ->
        queues ++ [Computer.Queue.new()]
      end)
    }
  end

  def count(multi) do
    Enum.count(multi.queues)
  end

end
