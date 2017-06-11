defmodule CommandTest do
  use ExUnit.Case
  doctest Computer.Command

  alias Computer.Command

  test "execute only command" do
    assert {:ok, command} = Command.new(%{execute: 10})
    assert command.wait == 0
    assert command.sync == :block
    assert Command.duration(command) == 10
  end

  test "partial command" do
    assert {:ok, command} = Command.new(%{wait: 5, execute: 10})
    assert command.sync == :block
    assert Command.duration(command) == 15
  end

  test "partial command async" do
    assert {:ok, command} = Command.new(%{sync: :async, execute: 10})
    assert command.sync == :async
    assert Command.duration(command) == 10
  end

  test "full command" do
    assert {:ok, command} = Command.new(%{sync: :async, wait: 5, execute: 10})
    assert command.sync == :async
    assert Command.duration(command) == 15
  end

  test "idle command" do
    assert {:ok, command} = Command.new()
    assert Command.duration(command) == 0
  end

  test "set :end" do
    assert {:ok, command} = Command.new(%{sync: :async, wait: 5, execute: 10})
    command = %{command | sync: :end}
    assert command.sync == :end
    assert Command.duration(command) == 15
  end
end
