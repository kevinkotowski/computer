defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer

  test "hello" do
    assert Computer.hello == :world
  end
end
