defmodule Rps.Game do
  use GenServer

  @type id :: String.t()
  @type player_id :: String.t()

  defstruct id: nil,
            players: MapSet.new(),
            moves: %{}

  # PUBLIC API

  @spec start_link(id()) :: GenServer.on_start()
  def start_link(game_id) do
    GenServer.start_link(__MODULE__, game_id, name: via(game_id))
  end

  @spec join(id(), player_id()) :: :ok | {:error, :game_full} | no_return
  def join(game_id, player_id) do
    GenServer.call(via(game_id), {:join, player_id})
  end

  @spec move(id, player_id, Rps.Rules.move()) ::
          :ok | {:error, :not_in_game} | {:error, :invalid_move} | no_return
  def move(game_id, player_id, move) do
    GenServer.call(via(game_id), {:move, player_id, move})
  end

  # CALLBACKS

  def init(game_id) do
    state = %__MODULE__{id: game_id}
    {:ok, state}
  end

  def handle_call({:join, player_id}, _from, state) do
    if game_full?(state) do
      {:reply, {:error, :game_full}, state}
    else
      new_state = %{state | players: MapSet.put(state.players, player_id)}
      {:reply, :ok, new_state}
    end
  end

  def handle_call({:move, player_id, move}, _from, state) do
    with :ok <- check_player_in_game(state, player_id),
         :ok <- Rps.Rules.validate_move(move) do
      new_state = %{state | moves: Map.put(state.moves, player_id, move)}
      {:reply, :ok, new_state}
    else
      error ->
        {:reply, error, state}
    end
  end

  # PRIVATE

  defp via(game_id) do
    {:via, Registry, {Registry.Game, game_id}}
  end

  defp check_player_in_game(state, player_id) do
    if MapSet.member?(state.players, player_id) do
      :ok
    else
      {:error, :not_in_game}
    end
  end

  defp game_full?(state) do
    MapSet.size(state.players) >= 2
  end
end
