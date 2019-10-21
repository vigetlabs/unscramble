defmodule UnscrambleTest do
  use ExUnit.Case, async: false

  doctest Unscramble

  @jumbles %{
    "tmorcpue" => "computer",
    "crootd" => "doctor",
    "salos" => "lasso, ossal",
    "gfroo" => "forgo",
    "cluen" => "uncle",
    "rubwor" => "burrow",
    "nitmyu" => "munity, mutiny",
    "ittcek" => "ticket",
    "cuthh" => "hutch",
    "rptiem" => "permit",
    "fryrul" => "flurry",
    "ot" => "to",
    "hye" => "hey",
    "ebdt" => "debt"
  }

  setup do
    # Temporary stuff to fix improper test exits which leave the cache in a weird
    # state. Sometimes this still fails and you have to `rm unscramble.tab` before
    # running it again and successfully regenerating the cache file.
    Unscramble.Cache.clear()
    Unscramble.Cache.initialize()
    :ok
  end

  test "parse/1 parses scrambled words" do
    duration = measure(fn ->
      Enum.each(@jumbles, fn {scramble, word} ->
        assert Unscramble.parse(scramble) == word
      end)
    end)

    IO.puts("\nSample Test Case: #{duration}ms")

    Unscramble.Cache.clear()
  end

  test "parse/1 doesn't parse non-sense input" do
    duration = measure(fn ->
      assert Unscramble.parse("zzzzzzzzzzzzz") == nil
    end)

    IO.puts("\nNil Case: #{duration}ms")

    Unscramble.Cache.clear()
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

    duration = measure(fn ->
      Enum.each(cases, fn [scrambled_word, word] ->
        assert String.contains?(Unscramble.parse(scrambled_word), word)
      end)
    end)

    IO.puts("\n#{quantity} Lookups: #{duration}ms")

    Unscramble.Cache.clear()
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

  defp measure(callback) do
    start = now()
    callback.()
    finish = now()

    DateTime.diff(finish, start, :millisecond)
  end
end
