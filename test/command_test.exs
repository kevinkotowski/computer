defmodule CommandTest do
  use ExUnit.Case
  doctest Computer.Command

  alias Computer.Command

  test "process command" do
    assert {:ok, command} = Command.new(sync: :block, wait: 5, process: 10)
    assert Command.duration(command) == 15
  end

end
