defmodule ProcessesTest do
  use ExUnit.Case
  doctest Computer.Processes

  alias Computer.Processes
  alias Computer.Command

  test "new processes multiqueue" do
    processes = Processes.new(1)
    assert Processes.peek(processes) == [0]

    processes = Processes.new(4)
    assert Processes.peek(processes) == [0,0,0,0]
  end

  test "push command lists" do
    processes = Processes.new(3)
      |> Processes.push(build_program(3))
      |> Processes.push(build_program(4))
    assert Processes.peek(processes) == [6,10,0]

    {:ok, command2} = Command.new(%{execute: 2})
    {:ok, command4} = Command.new(%{execute: 4})
    {:ok, command6} = Command.new(%{execute: 6})
    processes = Processes.push(processes, [command2])
    assert Processes.peek(processes) == [6,10,2]

    processes = Processes.push(processes, [command4])
    assert Processes.peek(processes) == [6,10,6]

    processes = Processes.push(processes, [command6])
    assert Processes.peek(processes) == [12,10,6]
  end

  test "pop blocking commands and rotate queues" do
    processes = Processes.new(3)
      |> Processes.push(build_program(3))
      |> Processes.push(build_program(2))
      |> Processes.push(build_program(4))
      |> Processes.push(build_program(3))
      |> Processes.push(build_program(1))
    assert Processes.peek(processes) == [7,9,10]
    {processes, commands} = Processes.pop(processes)
    assert Computer.Queue.peek(commands) == 6
    assert Processes.peek(processes) == [9,10,1]
  end

  def build_program(count) do
    Enum.reduce(1..count, [], fn(index, commands) ->
      {:ok, command} = Command.new(%{execute: index})
      commands ++ [command]
    end)
  end

end
