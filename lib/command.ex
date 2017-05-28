defmodule Computer.Command do
  alias __MODULE__

  defstruct [
    sync: :block, wait: 0, process: 0
  ]

  @opaque t :: %Command{
    sync: sync,
    wait: integer,
    process: integer
  }

  @type sync :: :block | :async
  @type unit :: :wait | :process | :idle

  @spec new(Command) :: {:ok, t | :error}
  def new(command) do
    { :ok, command }
  end

  @spec duration(t) :: integer
  def duration(command), do:
    command[:wait] + command[:process]
end
