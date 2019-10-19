defmodule Unscramble do
  @moduledoc """
  Documentation for Unscramble.
  """

  def parse(word) do
    case Unscramble.Cache.find(word) do
      matches -> present_answers(matches)
      [] -> nil
    end
  end

  defp present_answers(matches) do
    present_answers(matches, [])
  end

  defp present_answers([{_, word} | rest], words) do
    present_answers(rest, [word | words])
  end

  defp present_answers([], words) do
    words |> Enum.reverse() |> Enum.join(", ")
  end
end
