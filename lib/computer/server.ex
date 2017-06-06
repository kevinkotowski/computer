defmodule Computer.Server do
  alias __MODULE__
  alias Computer.Cpu
  alias Computer.Command

  defstruct [:tick, :requests, :tasks, :cpus]

  @opaque t :: %Server{
    tick: integer,
    requests: Computer.Queue,
    tasks: Computer.Queue,
    cpus: [Cpu]
  }

  @spec new() :: t
  def new() do
    %Server{
      tick: 0,
      requests: Computer.Queue.new(),
      tasks: Computer.Queue.new(),
      cpus: [Cpu.new()]
    }
  end

end
