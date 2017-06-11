defmodule CpuTest do
  use ExUnit.Case
  doctest Computer.Cpu

  alias Computer.Cpu
  alias Computer.Command

  test "new cpu" do
    cpu = Cpu.new()
    assert cpu.command.sync == :block
    assert cpu.command.wait == 0
    assert cpu.command.execute == 0
    assert Cpu.peek(cpu) == 0
    assert {:idle, _cpu} = Cpu.tick(cpu)
  end

  test "cpu fetch is okay" do
    cpu = Cpu.new()
    {:ok, command} = Command.new(%{execute: 2, wait: 1})

    {:ok, cpu} = Cpu.fetch(cpu, command)
    assert cpu.command.wait == 1
    assert {:wait, cpu} = Cpu.tick(cpu)
    assert cpu.command.wait == 0
    assert {:process, cpu} = Cpu.tick(cpu)
    assert {:process, cpu} = Cpu.tick(cpu)
    assert {:idle, _cpu} = Cpu.tick(cpu)
  end

  test "cpu fetch is busy" do
    cpu = Cpu.new()
    {:ok, command} = Command.new(%{execute: 2, wait: 1})

    {:ok, cpu} = Cpu.fetch(cpu, command)
    {:busy, ticks} = Cpu.fetch(cpu, command)
    assert ticks == 3
    assert cpu.command.wait == 1
  end

end
