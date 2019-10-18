defmodule Unscramble.CLI do
  @moduledoc """
  Documentation for Unscramble.
  """
  def main([scrambled_word | _]) do
    Unscramble.parse(scrambled_word)
  end
end
