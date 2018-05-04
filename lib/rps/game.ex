defmodule Rps.Game do
  use GenServer

  @type id :: String.t

  # PUBLIC API

  @spec start_link(id()) :: GenServer.on_start()
  def start_link(id) do
    GenServer.start_link(__MODULE__, %{}, name: via(id))
  end

  # CALLBACKS

  def init(args) do
    {:ok, args}
  end

  # PRIVATE

  defp via(id) do
    {:via, Registry, {Registry.Game, id}}
  end
end
