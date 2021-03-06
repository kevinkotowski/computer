defmodule CommandTest do
  use ExUnit.Case
  doctest Computer.Command

  alias Computer.Command

  test "default command" do
    assert {:ok, command} = Command.new()
    assert command.wait == 0
    assert command.sync == :block
    assert Command.duration(command) == 0
  end

  test "process only command" do
    assert {:ok, command} = Command.new(%{process: 10})
    assert command.wait == 0
    assert command.sync == :block
    assert Command.duration(command) == 10
  end

  test "partial command" do
    assert {:ok, command} = Command.new(%{wait: 5, process: 10})
    assert command.sync == :block
    assert Command.duration(command) == 15
  end

  test "partial command async" do
    assert {:ok, command} = Command.new(%{sync: :async, process: 10})
    assert command.sync == :async
    assert Command.duration(command) == 10
  end

  test "full command" do
    assert {:ok, command} = Command.new(%{sync: :async, wait: 5, process: 10})
    assert command.sync == :async
    assert Command.duration(command) == 15
  end

end
