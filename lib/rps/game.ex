defmodule Rps.Game do
  alias Rps.Rules

  defstruct id: nil,
            moves: %{}

  @type id :: String.t()
  @type player_id :: String.t()
  @type moves :: %{optional(player_id) => :undecided | Rules.move()}
  @type t :: %__MODULE__{id: nil | id, moves: moves}
  @type result :: player_id | :draw

  @type on_join :: :ok | {:error, :game_full}
  @type on_move :: :ok | {:error, :not_in_game} | {:error, :invalid_move}
  @type on_complete :: boolean
  @type on_result :: {:ok, result} | {:error, :not_finished}

  @spec new(id) :: t
  def new(id) do
    %__MODULE__{id: id}
  end

  @spec join(t, player_id) :: on_join
  def join(game, player_id) do
    if full?(game) do
      {:error, :game_full}
    else
      new_game = %{game | moves: Map.put(game.moves, player_id, :undecided)}
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

  @spec complete?(t) :: on_complete
  def complete?(game) do
    full?(game) and all_players_moved?(game)
  end

  @spec result(t) :: on_result
  def result(game) do
    if complete?(game) do
      {:ok, game_result(game)}
    else
      {:error, :not_finished}
    end
  end

  defp check_player_in_game(game, player_id) do
    if Map.has_key?(game.moves, player_id) do
      :ok
    else
      {:error, :not_in_game}
    end
  end

  defp full?(game) do
    Map.size(game.moves) == 2
  end

  defp all_players_moved?(game) do
    :undecided not in Map.values(game.moves)
  end

  defp game_result(game) do
    [{player_one, move_one}, {player_two, move_two}] = Map.to_list(game.moves)

    case Rules.winner(move_one, move_two) do
      ^move_one -> player_one
      ^move_two -> player_two
      draw -> draw
    end
  end
end
