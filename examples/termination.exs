Application.ensure_all_started(:rps)

{:ok, _id, pid} = Rps.start_game()

send(pid, :unhandled_message)

Process.sleep(100)

{:ok, _id, pid} = Rps.start_game()

Supervisor.stop(Rps.Game.Supervisor)

Process.sleep(100)
