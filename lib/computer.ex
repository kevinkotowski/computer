defmodule Computer do
  @moduledoc """
  Simulate programs running in blocking, concurrent, and fully parallel servers.
  """

  @doc """
  #program
  [
    {process: 10},
    {wait: 200, process: 10},
    {sync: :async, wait: 200, process: 10},
  ]
  #computer
  {
    requests: 16,
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
