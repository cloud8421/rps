defmodule Rps do
  @moduledoc """
  Public API to manage games.
  """

  @doc """
  Starts a new game, generating a random id for the game.
  """
  @spec start_game() :: {:ok, Rps.Game.id(), pid}
  def start_game do
    case start_game(generate_id()) do
      {:error, {:already_started, _pid}} ->
        start_game()

      success ->
        success
    end
  end

  @doc """
  Starts a new game given a game id.
  """
  @spec start_game(Rps.Game.id()) :: {:ok, Rps.Game.id(), pid} | {:error, {:already_started, pid}}
  def start_game(game_id) do
    case Rps.Game.Supervisor.start_game(game_id) do
      {:ok, pid} ->
        {:ok, game_id, pid}

      error ->
        error
    end
  end

  @doc """
  Joins a game given a game id and a player id.
  """
  @spec join(Rps.Game.id(), Rps.Game.player_id()) :: Rps.Game.Session.on_join()
  def join(game_id, player_id), do: Rps.Game.Session.join(game_id, player_id)

  @doc """
  Joins a game given a game id and a player id.
  """
  @spec move(Rps.Game.id(), Rps.Game.player_id(), Rps.Rules.move()) :: Rps.Game.Session.on_move()
  def move(game_id, player_id, move), do: Rps.Game.Session.move(game_id, player_id, move)

  defp generate_id do
    :rand.uniform(1_000_000_000)
    |> to_string
  end
end
