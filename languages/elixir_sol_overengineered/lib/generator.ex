defmodule Unscramble.Generator do
  @dict "/usr/share/dict/words"

  def generate(offset \\ 0) do
    dictionary_stream()
    |> Stream.drop(offset)
    |> Stream.map(&String.trim/1)
    |> Stream.flat_map(fn word ->
      scramble(word)
      |> Enum.intersperse(word)
      |> Enum.chunk_every(2, 2, [word])
    end)
  end

  # private

  defp dictionary_stream() do
    File.stream!(@dict)
  end

  defp scramble(word),
    do: scramble(word, {[], String.length(word)})

  defp scramble(_, {scrambles, 0}),
    do: MapSet.new(scrambles)

  defp scramble(word, {scrambles, rounds}),
    do: scramble(word, {[variation(word) | scrambles], rounds - 1})

  defp variation(word) do
    word
    |> String.split("", trim: true)
    |> Enum.shuffle()
    |> List.to_string()
  end
end
