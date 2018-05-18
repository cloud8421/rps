Application.ensure_all_started(:rps)

{:ok, _id, pid} = Rps.start_game()

send(pid, :unhandled_message)

Process.sleep(100)
