Application.ensure_all_started(:rps)

divider = fn text ->
  IO.puts(IO.ANSI.green() <> text <> IO.ANSI.reset())
end

{:ok, game_id, game_pid} = Rps.start_game()

divider.("===> ENABLE STATS")

:sys.statistics(game_pid, true)

Rps.join(game_id, "player-one")

Rps.join(game_id, "player-two")

Rps.move(game_id, "player-one", :rock)

divider.("===> GET STATS")

:sys.statistics(game_pid, :get) |> IO.inspect()
