# Rps

# GenServer under the microscope

## Intro

The aim of this tutorial is to show some day to day techniques that can be used when working with generic servers.
The codebase we will be working on is written in Elixir, but techniques can be applied to other BEAM languages as well.

The project requires Elixir >= 1.6.0.

After cloning the repository, we can checkout the `starter` branch and run:

`mix do deps.get, compile`

A basic integration test is included, which can be run with `mix test`.

## Example application

The application represents the core engine for a game of rock, paper, scissors. If you've never played this game, please refer to [the relevant Wikipedia page](https://en.wikipedia.org/wiki/Rock%E2%80%93paper%E2%80%93scissors).

## Features

- Create game sessions
- Players can join a session
- After playing, the winner takes 1 point
- Score is recorded in-memory for ephemeral glory
- Playable via an IEx console

## Structure

- Each game session is represented by a process, implemented as a [GenServer](https://hexdocs.pm/elixir/GenServer.html). See [Rps.Game.Session](https://github.com/cloud8421/rps/blob/starter/lib/rps/game/session.ex).
- Games are managed via a [DynamicSupervisor](https://hexdocs.pm/elixir/DynamicSupervisor.html). See [Rps.Game.Supervisor](https://github.com/cloud8421/rps/blob/starter/lib/rps/game/supervisor.ex).
- Score is recorded in a ETS table. See [Rps.Score](https://github.com/cloud8421/rps/blob/starter/lib/rps/score.ex).
