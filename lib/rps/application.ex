defmodule Rps.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Registry, keys: :unique, name: Registry.Game},
      Rps.Game.Supervisor
      # Starts a worker by calling: Rps.Worker.start_link(arg)
      # {Rps.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rps.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_phase(:create_score_table, _type, _args) do
    Rps.Score.create_table()
  end
end
