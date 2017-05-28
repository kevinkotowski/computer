defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer

  test "52 cards" do
    assert length(Computer.shuffled()) == 52
  end
end
