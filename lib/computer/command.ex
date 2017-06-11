defmodule Computer.Command do
  alias __MODULE__

  defstruct sync: :block, wait: 0, execute: 0

  @type t :: %Command{}
  @type sync :: :block | :async
  @type unit :: :wait | :execute | :idle

  def new(%{idle: _} = command) do
    { :ok, Map.merge(%Command{}, command) }
  end
  def new(%{execute: _} = command) do
    { :ok, Map.merge(%Command{}, command) }
  end

  @spec duration(t) :: integer
  def duration(%Command{} = command), do:
    command.wait + command.execute
end
