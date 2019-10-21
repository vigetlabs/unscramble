defmodule Unscramble.CLI do
  @moduledoc """
  Documentation for Unscramble.
  """
  def main([scrambled_word | _]) do
    Unscramble.Cache.initialize()
    answer = Unscramble.parse(scrambled_word)
    Unscramble.Cache.clear()

    IO.puts(answer)
  end
end
