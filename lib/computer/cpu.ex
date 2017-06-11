defmodule Computer.Cpu do
  alias __MODULE__
  alias Computer.Command

  defstruct [:command]

  @opaque t :: %Cpu{command: Command}

  def new() do
    {:ok, command} = Command.new()
    %Cpu{command: command}
  end

  @spec fetch(t, Command) :: {:ok, t} | {:busy, integer}
  def fetch(%Cpu{} = cpu, %Command{} = command) do
    case peek(cpu) do
      0 -> {:ok, %Cpu{command: command}}
      _ -> {:busy, Command.duration(cpu.command)}
    end
  end

  @spec tick(t) :: {Command.unit, t}
  def tick(%Cpu{} = cpu) do
    case cpu.command do
      %{wait: 0, execute: 0} ->
        {:idle, cpu}
      %{wait: 0, execute: x} when x > 0 ->
        command = Map.merge(cpu.command, %{execute: x - 1})
        {:process, %Cpu{command: command}}
      %{wait: x, execute: _} when x > 0 ->
        command = Map.merge(cpu.command, %{wait: x - 1})
        {:wait, %Cpu{command: command}}
    end
  end

  def peek(%Cpu{} = cpu) do
    Command.duration(cpu.command)
  end
end
