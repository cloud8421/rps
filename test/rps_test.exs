defmodule RpsTest do
  use ExUnit.Case
  doctest Rps

  test "greets the world" do
    assert Rps.hello() == :world
  end
end
