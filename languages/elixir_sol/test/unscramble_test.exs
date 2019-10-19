defmodule UnscrambleTest do
  use ExUnit.Case, async: false

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
    # Temporary stuff to fix improper test exits which leave the cache in a weird
    # state. Sometimes this still fails and you have to `rm unscramble.tab` before
    # running it again and successfully regenerating the cache file.
    Unscramble.Cache.clear_cache()
    Unscramble.Cache.initialize_cache()
    :ok
  end

  test "parse/1" do
    Enum.each(@jumbles, fn {key, value} ->
      assert Unscramble.parse(key) == value
    end)

    Unscramble.Cache.clear_cache()
  end

  test "converts 10" do
    test_with_sample_size(10)
  end

  test "converts 500" do
    test_with_sample_size(500)
  end

  test "converts 5000" do
    test_with_sample_size(5000)
  end

  test "converts 50000" do
    test_with_sample_size(50000, 150_000, 50_000)
  end


  test "converts 500000" do
    test_with_sample_size(500_000, 150_000, 50_000)
  end

  defp test_with_sample_size(quantity, range \\ 200_000, offset \\ 100_000) do
    cases = make_cases(quantity, range, offset)
    start = now()

    Enum.each(cases, fn [scrambled_word, word] ->
      assert String.contains?(Unscramble.parse(scrambled_word), word)
    end)

    finish = now()

    IO.puts "#{quantity} Lookups: #{DateTime.diff(finish, start, :millisecond)}ms"

    Unscramble.Cache.clear_cache()
  end

  defp make_cases(quantity, range, offset) do
    :rand.seed(:exsplus, {1, 2, 4})
    drop = :rand.uniform(range) + offset

    drop
    |> Unscramble.Generator.generate()
    |> Stream.take(quantity)
    |> Enum.to_list()
  end

  defp now(), do: DateTime.now("Etc/UTC") |> elem(1)
end
