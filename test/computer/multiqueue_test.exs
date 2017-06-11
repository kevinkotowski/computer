defmodule MultiqueueTest do
  use ExUnit.Case
  doctest Computer.Multiqueue

  alias Computer.Multiqueue
  alias Computer.Command

  test "new multiqueue" do
    multi = Multiqueue.new(1)
    assert Multiqueue.peek(multi) == [0]

    multi = Multiqueue.new(4)
    assert Multiqueue.peek(multi) == [0,0,0,0]
  end

  test "push and pop commands" do
    {:ok, command1} = Command.new(%{execute: 1})
    {:ok, command2} = Command.new(%{execute: 2})
    {:ok, command3} = Command.new(%{execute: 3})

    multi = Multiqueue.new(3)
      |> Multiqueue.push([command3])
      |> Multiqueue.push([command1])
      |> Multiqueue.push([command2])
    assert Multiqueue.shortest(multi) == 1
    assert Multiqueue.peek(multi) == [3,1,2]

    {:ok, command4} = Command.new(%{execute: 4})
    {:ok, command5} = Command.new(%{execute: 5})
    {:ok, command6} = Command.new(%{execute: 6})
    multi = Multiqueue.push(multi, [command4])
      |> Multiqueue.push([command5])
      |> Multiqueue.push([command6])
    assert Multiqueue.peek(multi) == [9,5,7]

    {multi, command} = Multiqueue.pop(multi)
    assert Command.duration(command) == 3
    assert Multiqueue.peek(multi) == [5,7,6]

    {multi, command} = Multiqueue.pop(multi)
    assert Command.duration(command) == 1
    assert Multiqueue.peek(multi) == [7,6,4]

    {multi, command} = Multiqueue.pop(multi)
    assert Command.duration(command) == 2
    assert Multiqueue.peek(multi) == [6,4,5]

    {multi, command} = Multiqueue.pop(multi)
    assert Command.duration(command) == 6
    assert Multiqueue.peek(multi) == [4,5,0]
  end

  test "push and pop command list" do
    {:ok, command1} = Command.new(%{execute: 1})
    {:ok, command2} = Command.new(%{execute: 2})
    {:ok, command3} = Command.new(%{execute: 3})

    program = [command1, command2, command3]

    multi = Multiqueue.new(3)
      |> Multiqueue.push(program)
    assert Multiqueue.shortest(multi) == 1
    assert Multiqueue.peek(multi) == [6,0,0]
  end
end
