defmodule UnscrambleTest do
  use ExUnit.Case
  doctest Unscramble

  @jumbles %{
    "tmorcpue"  => "computer",
    "crootd"    => "doctor",
    "salos"     => "lasso, ossal",
    "gfroo"     => "forgo",
    "cluen"     => "uncle",
    "rubwor"    => "burrow",
    "nitmyu"    => "munity, mutiny",
    "ittcek"    => "ticket",
    "cuthh"     => "hutch",
    "rptiem"    => "permit",
    "fryrul"    => "flurry",
    "ot"        => "to",
    "hye"       => "hey",
    "ebdt"      => "debt"
  }

  setup do
    Unscramble.Cache.initialize_cache()
    :ok
  end

  test "greets the world" do
    Enum.each(@jumbles, fn {key, value} ->
      assert Unscramble.parse(key) == value
    end)

    Unscramble.Cache.clear_cache()
  end
end
