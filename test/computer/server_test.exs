defmodule SeverTest do
  use ExUnit.Case
  doctest Computer.Server

  alias Computer.Server
  alias Computer.Queue
  # alias Computer.Command

  test "new server" do
    server = Server.new()
    assert server.tick == 0
    assert Queue.ticks(server.requests) == 0
  end

  # test "push and pop commands" do
  #   {:ok, command1} = Command.new(%{process: 1})
  #   {:ok, command2} = Command.new(%{process: 2})
  #   {:ok, command3} = Command.new(%{process: 3})
  #   queue = Queue.new()
  #   queue = Queue.push(queue, command1)
  #   queue = Queue.push(queue, command2)
  #   queue = Queue.push(queue, command3)
  #   assert Queue.ticks(queue) == 6
  #
  #   {queue, command} = Queue.pop(queue)
  #   assert Command.duration(command) == 1
  #   {queue, command} = Queue.pop(queue)
  #   assert Command.duration(command) == 2
  #   assert Queue.ticks(queue) == 3
  # end
end
