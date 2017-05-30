defmodule Computer.Cpu do
  alias __MODULE__
  alias Computer.Command

  defstruct [:command]

  @opaque t :: %Cpu{command: Command}

  def new() do
    {:ok, command} = Command.new
    %Cpu{command: command}
  end

  @spec fetch(t, Command) :: {:ok, t} | {:busy, integer}
  def fetch(%Cpu{} = cpu, %Command{} = command) do
    case idle?(cpu) do
      true -> {:ok, %Cpu{command: command}}
      false -> {:busy, Command.duration(cpu.command)}
    end
  end

  @spec tick(t) :: {Command.unit, t}
  def tick(%Cpu{} = cpu) do
    case cpu.command do
      %{wait: 0, process: 0} ->
        {:idle, cpu}
      %{wait: 0, process: x} when x > 0 ->
        command = Map.merge(cpu.command, %{process: x - 1})
        {:process, %Cpu{command: command}}
      %{wait: x, process: _} when x > 0 ->
        command = Map.merge(cpu.command, %{wait: x - 1})
        {:wait, %Cpu{command: command}}
    end
  end

  def idle?(%Cpu{} = cpu) do
    Command.duration(cpu.command) < 1
  end
end
