defmodule Computer.Server do
  alias __MODULE__
  alias Computer.Cpu
  alias Computer.Command
  alias Computer.Multiqueue

  defstruct [:tick, :requests, :tasks, :cpus]

  @opaque t :: %Server{
    tick: integer,
    requests: Computer.Multiqueue,
    tasks: Computer.Multiqueue,
    cpus: [Cpu]
  }

  def new() do
    new(4,4,2)
  end
  def new(request_queues, task_queues, cpu_queues) do
    %Server{
      tick: 0,
      requests: Computer.Multiqueue.new(request_queues),
      tasks: Computer.Multiqueue.new(task_queues),
      cpus: Enum.reduce(1..cpu_queues, [], fn(_, cpus) -> cpus ++ [Cpu.new()] end)
    }
  end

  def peek(server) do
    %{
      requests: Multiqueue.peek(server.requests),
      tasks: Multiqueue.peek(server.tasks),
      cpus: Enum.map(server.cpus, fn(cpu) -> Cpu.peek(cpu) end)
    }
  end
end
