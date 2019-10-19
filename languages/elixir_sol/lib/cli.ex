defmodule Unscramble.CLI do
  @moduledoc """
  Documentation for Unscramble.
  """
  def main([scrambled_word | _]) do
    Unscramble.Cache.initialize_cache()
    answer = Unscramble.parse(scrambled_word)
    Unscramble.Cache.clear_cache()

    IO.puts(answer)
  end
end
