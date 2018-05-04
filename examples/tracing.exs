Application.ensure_all_started(:rps)

divider = fn text ->
  IO.puts(IO.ANSI.green() <> text <> IO.ANSI.reset())
end

divider.("===> NO DEBUG INSTALLED")

{:ok, game_id, game_pid} = Rps.start_game()

Rps.join(game_id, "player-one")

divider.("===> START TRACING")

:sys.trace(game_pid, true)

Rps.join(game_id, "player-two")

divider.("===> STOP TRACING")

:sys.trace(game_pid, false)

divider.("===> START LOG")

:sys.log(game_pid, {true, 100})

Rps.move(game_id, "player-one", :rock)

:sys.log(game_pid, :print)

Rps.move(game_id, "player-two", :paper)

divider.("===> DONE")
