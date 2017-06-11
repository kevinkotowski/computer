defmodule QueueTest do
  use ExUnit.Case
  doctest Computer.Queue

  alias Computer.Queue
  alias Computer.Command

  test "new command queue" do
    queue = Queue.new()
    assert Queue.peek(queue) == 0
  end

  test "push and pop commands" do
    {:ok, command1} = Command.new(%{execute: 1})
    {:ok, command2} = Command.new(%{execute: 2})
    {:ok, command3} = Command.new(%{execute: 3})
    queue = Queue.new()
    assert Queue.peek(queue) == 0
    queue = Queue.append(queue, [command1])
    queue = Queue.append(queue, [command2, command3])
    assert Queue.peek(queue) == 6

    {queue, command} = Queue.pop(queue)
    assert Command.duration(command) == 1
    {queue, command} = Queue.pop(queue)
    assert Command.duration(command) == 2
    assert Queue.peek(queue) == 3
  end
end
