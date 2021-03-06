defmodule Rps.Rules do
  @type move :: :rock | :paper | :scissors
  @type result :: move | :draw

  @spec winner(move, move) :: result
  def winner(:rock, :paper), do: :paper
  def winner(:paper, :rock), do: :paper
  def winner(:scissors, :rock), do: :rock
  def winner(:rock, :scissors), do: :rock
  def winner(:paper, :scissors), do: :scissors
  def winner(:scissors, :paper), do: :scissors
  def winner(move, move), do: :draw

  def validate_move(:rock), do: :ok
  def validate_move(:paper), do: :ok
  def validate_move(:scissors), do: :ok
  def validate_move(_invalid), do: {:error, :invalid_move}
end
