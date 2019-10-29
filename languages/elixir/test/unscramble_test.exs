defmodule UnscrambleTest do
  use ExUnit.Case
  doctest Unscramble

  test "greets the world" do
    assert Unscramble.hello() == :world
  end
end
