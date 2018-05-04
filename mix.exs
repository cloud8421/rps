defmodule Rps.MixProject do
  use Mix.Project

  def project do
    [
      app: :rps,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer_warnings: [:unmatched_returns, :error_handling, :race_conditions, :unknown],
      dialyzer_ignored_warnings: [
        {:warn_contract_supertype, :_, {:extra_range, [:_, :__protocol__, 1, :_, :_]}}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Rps.Application, []},
      start_phases: [
        create_score_table: []
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyzex, "~> 1.1", only: :dev}
    ]
  end
end
