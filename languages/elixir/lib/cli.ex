defmodule Unscramble.CLI do
  @moduledoc """
  Documentation for Unscramble.
  """
  def main([scrambled_word | _]) do
    IO.puts(Unscramble.parse(scrambled_word) |> Enum.join(", "))
  end
end
