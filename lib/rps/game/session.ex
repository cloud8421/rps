defmodule Rps.Game.Session do
  use GenServer

  alias Rps.{Game, Rules}

  @type on_join :: Game.on_join() | no_return
  @type on_move :: Game.on_move() | no_return

  # PUBLIC API

  @spec start_link(Game.id()) :: GenServer.on_start()
  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: via(game_id))
  end

  @spec join(Game.id(), Game.player_id()) :: on_join
  def join(game_id, player_id) do
    GenServer.call(via(game_id), {:join, player_id})
  end

  @spec move(Game.id(), Game.player_id(), Rules.move()) :: on_move
  def move(game_id, player_id, move) do
    GenServer.call(via(game_id), {:move, player_id, move})
  end

  # CALLBACKS

  def init(game_id) do
    {:ok, Game.new(game_id)}
  end

  def handle_call({:join, player_id}, _from, game) do
    case Game.join(game, player_id) do
      {:ok, new_game} ->
        {:reply, :ok, new_game}

      error ->
        {:reply, error, game}
    end
  end

  def handle_call({:move, player_id, move}, _from, game) do
    case Game.move(game, player_id, move) do
      {:ok, new_game} ->
        {:reply, :ok, new_game}

      error ->
        {:reply, error, game}
    end
  end

  # PRIVATE

  defp via(game_id) do
    {:via, Registry, {Registry.Game, game_id}}
  end
end
