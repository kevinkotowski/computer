defmodule SeverTest do
  use ExUnit.Case
  doctest Computer.Runtime

  alias Computer.Runtime
  alias Computer.Command

  test "new default server" do
    assert_default_server(Runtime.new())
  end

  test "new server assign single threaded sizes" do
    server = Runtime.new(1,1,1)
    assert server.tick == 0
    assert Runtime.peek(server) == %{
      processes: [0],
      tasks: [0],
      cpus: [0]
    }
  end

  test "push programs to server" do
    server = Runtime.new()
      |> Runtime.push(build_program(1))
      |> Runtime.push(build_program(2))
      |> Runtime.push(build_program(3))
      |> Runtime.push(build_program(4))
      |> Runtime.push(build_program(5))
    assert Runtime.peek(server) == %{
      processes: [16,3,6,10],
      tasks: [0,0,0,0],
      cpus: [0,0]
    }
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

  def assert_default_server(server) do
    assert server.tick == 0
    assert Runtime.peek(server) == %{
      processes: [0,0,0,0],
      tasks: [0,0,0,0],
      cpus: [0,0]
    }
  end
  def build_program(count) do
    Enum.reduce(1..count, [], fn(index, commands) ->
      {:ok, command} = Command.new(%{execute: index})
      commands ++ [command]
    end)
  end
end
