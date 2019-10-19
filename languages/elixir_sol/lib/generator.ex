defmodule Unscramble.Generator do
  @dict "/usr/share/dict/words"

  def generate(offset \\ 0) do
    dictionary_stream()
    |> Stream.drop(offset)
    |> Stream.map(&String.trim/1)
    |> Stream.flat_map(fn word ->
      scramble(word)
      |> Enum.intersperse(word)
      |> Enum.chunk_every(2, 2, :discard)
    end)
  end

  def dictionary_stream() do
    File.stream!(@dict)
  end

  def scramble(word), do: scramble(word, {[], String.length(word)})
  def scramble(word, {variations, 0}), do: MapSet.new(variations)
  def scramble(word, {variations, iterations_remaining}) do
    scramble(word, {[variation(word) | variations], iterations_remaining - 1})
  end

  def variation(word) do
    word
    |> String.split("", trim: true)
    |> Enum.shuffle()
    |> List.to_string()
  end
end
