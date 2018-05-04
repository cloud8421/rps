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
  @spec start_game() :: {:ok, Rps.Game.id(), pid} | {:error, {:already_started, pid}}
  def start_game(id) do
    case Rps.Game.Supervisor.start_game(id) do
      {:ok, pid} ->
        {:ok, id, pid}

      error ->
        error
    end
  end

  defp generate_id do
    :rand.uniform(1_000_000_000)
    |> to_string
  end
end
