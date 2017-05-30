defmodule Computer do
  @moduledoc """
  Simulate programs running in blocking, concurrent, and fully parallel servers.
  """

  @doc """
  #program
  [
    {:block, {process: 10}},
    {:block, {wait: 200, process: 10}},
    {:async, {wait: 200, process: 10}},
    {:block, {process: 40}},
    {:block, {process: 50}},
    {:async, {wait: 100, process: 10}},
    {:block, {process: 100}}
  ]
  #computer
  {
    requests: 1024,
    tasks: 64,
    cpus: 4
  }
  """
  alias __MODULE__

  defstruct [:tick, :requests, :tasks, :cpus]

  @opaque t :: %Computer{
    tick: integer,
    requests: Computer.Queue,
    tasks: Computer.Queue,
    cpus: integer
  }

  @type unit :: :process | :wait | :idle

  def hello do
    :world
  end
end
