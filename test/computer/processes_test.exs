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

  test "push programs and commands" do
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

  test "pop blocking commands" do
    processes = Processes.new(3)
      |> Processes.push(build_program(3))
      |> Processes.push(build_program(3))
    assert Processes.peek(processes) == [6,6,0]
    # {processes, commands} = Processes.pop(processes)
    # assert commands == []
    # assert length(commands) == 3
    # assert Processes.peek(processes) == [0,6,0]
  end
  #
  # test "push and pop dependent commands" do
  #   {:ok, command1} = Command.new(%{execute: 1})
  #   {:ok, command2} = Command.new(%{execute: 2})
  #   {:ok, command3} = Command.new(%{execute: 3})
  #
  #   program = [command1, command2, command3]
  #
  #   multi = Multiqueue.new(3)
  #     |> Multiqueue.push(program)
  #   assert Multiqueue.shortest(multi) == 1
  #   assert Multiqueue.peek(multi) == [6,0,0]
  # end
  #
  # def new_program(count) do
  #    Enum.reduce(1..count, [], fn(_, commands) ->
  #      commands ++ [Command.new()]
  #    end)
  # end

  def build_program(count) do
    Enum.reduce(1..count, [], fn(index, commands) ->
      {:ok, command} = Command.new(%{execute: index})
      commands ++ [command]
    end)
  end

end
