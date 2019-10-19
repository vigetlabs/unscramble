defmodule Unscramble.Helpers do
  def tuple_from_word(word) do
    w =
      word
      |> String.downcase()
      |> String.trim()
      |> String.to_charlist()

    {product(w), sum(w)}
  end

  def product(charlist) do
    charlist |> Enum.reduce(1, &Kernel.*/2)
  end

  def sum(charlist) do
    charlist |> Enum.sum()
  end
end
