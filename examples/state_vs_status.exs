Application.ensure_all_started(:rps)

divider = fn text ->
  IO.puts(IO.ANSI.green() <> text <> IO.ANSI.reset())
end

{:ok, _game_id, game_pid} = Rps.start_game()

divider.("===> GET STATE")

:sys.get_state(game_pid) |> IO.inspect()

divider.("===> GET STATUS")

:sys.get_status(game_pid) |> IO.inspect()
