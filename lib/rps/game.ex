defmodule Rps.Game do
  alias Rps.Rules

  defstruct id: nil,
            players: MapSet.new(),
            moves: %{}

  @type id :: String.t()
  @type player_id :: String.t()
  @type t :: %__MODULE__{id: nil | id, players: MapSet.t(), moves: Map.t()}

  @type on_join :: :ok | {:error, :game_full}
  @type on_move :: :ok | {:error, :not_in_game} | {:error, :invalid_move}

  @spec new(id) :: t
  def new(id) do
    %__MODULE__{id: id}
  end

  @spec join(t, player_id) :: on_join
  def join(game, player_id) do
    if full?(game) do
      {:error, :game_full}
    else
      new_game = %{game | players: MapSet.put(game.players, player_id)}
      {:ok, new_game}
    end
  end

  @spec move(t, player_id, Rules.move()) :: on_move
  def move(game, player_id, move) do
    with :ok <- check_player_in_game(game, player_id),
         :ok <- Rules.validate_move(move) do
      new_game = %{game | moves: Map.put(game.moves, player_id, move)}
      {:ok, new_game}
    end
  end

  defp check_player_in_game(game, player_id) do
    if MapSet.member?(game.players, player_id) do
      :ok
    else
      {:error, :not_in_game}
    end
  end

  defp full?(game) do
    MapSet.size(game.players) >= 2
  end
end
