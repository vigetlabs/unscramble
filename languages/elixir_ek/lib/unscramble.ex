defmodule Unscramble do
  @moduledoc """
  Documentation for Unscramble.
  """
  def parse(input) do
    hashed_input = make_hash(input)
    input_length = String.length(input)
    words = prepare_dictionary()

    find_match(words, input, hashed_input, input_length)
  end

  def find_match([head | tail], input, hashed_input, input_length) do
    cond do
      (String.length(head) == input_length && make_hash(head) == hashed_input) ->
        head
      true ->
        find_match(tail, input, hashed_input, input_length)
      end
  end

  def find_match([], _input, _hashed_input, _input_length) do
    "No Matches"
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
