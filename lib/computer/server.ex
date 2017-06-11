defmodule Computer.Runtime do
  alias __MODULE__
  alias Computer.Cpu
  alias Computer.Command
  alias Computer.Processes
  alias Computer.Tasks

  defstruct [:tick, :processes, :tasks, :cpus]

  @opaque t :: %Runtime{
    tick: integer,
    processes: Computer.Processes,
    tasks: Computer.Tasks,
    cpus: [Cpu]
  }

  def new() do
    new(4,4,2)
  end
  def new(process_queues, task_queues, cpu_queues) do
    %Runtime{
      tick: 0,
      processes: Processes.new(process_queues),
      tasks: Tasks.new(task_queues),
      cpus: Enum.reduce(1..cpu_queues, [], fn(_, cpus) -> cpus ++ [Cpu.new()] end)
    }
  end

  def push(%Runtime{} = runtime, [%Command{}|_] = commands) do
    %Runtime{runtime | processes: Processes.push(runtime.processes, commands)}
  end

  def peek(server) do
    %{
      processes: Processes.peek(server.processes),
      tasks: Tasks.peek(server.tasks),
      cpus: Enum.map(server.cpus, fn(cpu) -> Cpu.peek(cpu) end)
    }
  end
end
