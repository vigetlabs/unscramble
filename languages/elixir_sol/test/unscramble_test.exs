defmodule UnscrambleTest do
  use ExUnit.Case
  doctest Unscramble

  test "make_hash/1" do
    assert Unscramble.make_hash("hello") == %{"h" => 1, "e" => 1, "l" => 2, "o" => 1}
  end
end
