defmodule Unscramble.Helpers do
  def tuple_from_word(word) do
    normalized_word = word
    |> String.downcase()
    |> String.trim()
    |> String.to_charlist()

    {letter_product(normalized_word), letter_sum(normalized_word)}
  end

  def letter_product(charlist) do
    charlist |> Enum.reduce(1, &Kernel.*/2)
  end

  def letter_sum(charlist) do
    charlist |> Enum.sum()
  end
end
