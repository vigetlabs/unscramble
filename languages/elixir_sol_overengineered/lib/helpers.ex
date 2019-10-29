defmodule Unscramble.Helpers do
  def tuple_from_word(word) do
    chars =
      word
      |> String.downcase()
      |> String.trim()
      |> String.to_charlist()

    {product(chars), sum(chars)}
  end

  # private

  defp product(charlist) do
    charlist |> Enum.reduce(1, &Kernel.*/2)
  end

  defp sum(charlist) do
    charlist |> Enum.sum()
  end
end
