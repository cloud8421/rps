defmodule Rps.Game.Supervisor do
  use DynamicSupervisor

  # PUBLIC API

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_game(id) do
    DynamicSupervisor.start_child(__MODULE__, {Rps.Game, id})
  end

  # CALLBACKS

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
