defmodule Rps.Score do
  @spec create_table :: :ok
  def create_table do
    __MODULE__ = :ets.new(__MODULE__, [:set, :public, :named_table])
    :ok
  end

  @spec record(Rps.Game.result()) :: :ok
  def record(:draw), do: :ok

  def record(result) do
    :ets.update_counter(__MODULE__, result, 1, {result, 0})
    :ok
  end

  @spec all() :: [{Rps.Game.player_id(), pos_integer}]
  def all, do: :ets.tab2list(__MODULE__)
end
