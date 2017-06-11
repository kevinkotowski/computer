defmodule TasksTest do
  use ExUnit.Case
  doctest Computer.Tasks

  alias Computer.Tasks
  alias Computer.Command

  test "new multiqueue" do
    multi = Tasks.new(1)
    assert Tasks.peek(multi) == [0]

    multi = Tasks.new(4)
    assert Tasks.peek(multi) == [0,0,0,0]
  end

  test "push and pop commands" do
    {:ok, command1} = Command.new(%{execute: 1})
    {:ok, command2} = Command.new(%{execute: 2})
    {:ok, command3} = Command.new(%{execute: 3})

    multi = Tasks.new(3)
      |> Tasks.push([command3])
      |> Tasks.push([command1])
      |> Tasks.push([command2])
    assert Tasks.shortest(multi) == 1
    assert Tasks.peek(multi) == [3,1,2]

    {:ok, command4} = Command.new(%{execute: 4})
    {:ok, command5} = Command.new(%{execute: 5})
    {:ok, command6} = Command.new(%{execute: 6})
    multi = Tasks.push(multi, [command4])
      |> Tasks.push([command5])
      |> Tasks.push([command6])
    assert Tasks.peek(multi) == [9,5,7]

    {multi, command} = Tasks.pop(multi)
    assert Command.duration(command) == 3
    assert Tasks.peek(multi) == [5,7,6]

    {multi, command} = Tasks.pop(multi)
    assert Command.duration(command) == 1
    assert Tasks.peek(multi) == [7,6,4]

    {multi, command} = Tasks.pop(multi)
    assert Command.duration(command) == 2
    assert Tasks.peek(multi) == [6,4,5]

    {multi, command} = Tasks.pop(multi)
    assert Command.duration(command) == 6
    assert Tasks.peek(multi) == [4,5,0]
  end

  test "push and pop command list" do
    {:ok, command1} = Command.new(%{execute: 1})
    {:ok, command2} = Command.new(%{execute: 2})
    {:ok, command3} = Command.new(%{execute: 3})

    program = [command1, command2, command3]

    multi = Tasks.new(3)
      |> Tasks.push(program)
    assert Tasks.shortest(multi) == 1
    assert Tasks.peek(multi) == [6,0,0]
  end
end
