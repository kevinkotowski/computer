defmodule Computer.Command do
  alias __MODULE__

  defstruct sync: :block, wait: 0, process: 0

  @type t :: %Command{}
  @type sync :: :block | :async
  @type unit :: :wait | :process | :idle

  def new() do
    { :ok, %Command{} }
  end
  def new(command) do
    { :ok, Map.merge(%Command{}, command) }
  end

  @spec duration(t) :: integer
  def duration(%Command{} = command), do:
    command.wait + command.process
end
