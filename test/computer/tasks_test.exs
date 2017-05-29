defmodule TasksTest do
  use ExUnit.Case
  doctest Computer.Tasks

  alias Computer.Tasks
  alias Computer.Command

  test "new tasks queue" do
    tasks = Tasks.new()
    assert tasks.commands == nil
  end

  test "push and pop commands" do
    {:ok, command1} = Command.new(%{process: 1})
    {:ok, command2} = Command.new(%{process: 2})
    {:ok, command3} = Command.new(%{process: 3})
    tasks = Tasks.new()
    tasks = Tasks.push(tasks, command1)
    tasks = Tasks.push(tasks, command2)
    tasks = Tasks.push(tasks, command3)
    assert Tasks.ticks(tasks) == 6

    {tasks, command} = Tasks.pop(tasks)
    assert Command.duration(command) == 1
    {tasks, command} = Tasks.pop(tasks)
    assert Command.duration(command) == 2
    assert Tasks.ticks(tasks) == 3
  end
end
