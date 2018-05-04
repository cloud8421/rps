defmodule Rps.Test do
  use ExUnit.Case

  test "example game session" do
    {:ok, game_id, game_pid} = Rps.start_game()

    # JOIN

    assert :ok == Rps.join(game_id, "player-one")
    assert :ok == Rps.join(game_id, "player-two")
    assert {:error, :game_full} == Rps.join(game_id, "player-three")

    # MOVES

    assert {:error, :invalid_move} == Rps.move(game_id, "player-one", :fire)
    assert {:error, :not_in_game} == Rps.move(game_id, "player-three", :rock)

    assert :ok == Rps.move(game_id, "player-one", :rock)
    assert :ok == Rps.move(game_id, "player-one", :scissors)
    assert :ok == Rps.move(game_id, "player-two", :paper)

    refute Process.alive?(game_pid)
  end
end
