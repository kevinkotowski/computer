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
    requests: [integer],
    tasks: [integer],
    cpus: integer
  }

  @type card :: %{suit: suit, rank: rank}
  @type suit :: :spades | :hearts | :diamonds | :clubs
  @type rank :: 2..10 | :jack | :queen | :king | :ace
  @type unit :: :process | :wait | :idle

  @cards (
    for suit <- [:spades, :hearts, :diamonds, :clubs],
        rank <- [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace],
      do: %{suit: suit, rank: rank}
  )


  @spec shuffled() :: t
  def shuffled(), do:
    Enum.shuffle(@cards)

  @spec take(t) :: {:ok, card, t} | {:error, :empty}
  def take([card | rest]), do:
    {:ok, card, rest}
  def take([]), do:
    {:error, :empty}

  def hello do
    :world
  end
end
