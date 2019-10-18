defmodule Unscramble do
  @moduledoc """
  Documentation for Unscramble.
  """
  def parse(letters) do
    input = make_hash(letters)
    lookup = prepare_dictionary()
  end

  def make_hash(letters) do
    make_hash(String.split(letters, "", trim: true), %{})
  end

  def make_hash([head|tail], acc) do
    cond do
      Map.has_key?(acc, head) ->
        make_hash(tail, Map.put(acc, head, acc[head] + 1))
      true ->
        make_hash(tail, Map.put(acc, head, 1))
    end
  end

  def make_hash([], acc), do: acc

  def prepare_dictionary() do
    File.read!("/usr/share/dict/words")
    |> String.split("\n")
  end
end
