defmodule UnscrambleTest do
  use ExUnit.Case
  doctest Unscramble

  test "unscrambles the world" do
    assert Unscramble.parse("ldwor") == ["world"]
  end
end
