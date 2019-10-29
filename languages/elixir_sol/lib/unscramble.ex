defmodule Unscramble do
  @moduledoc """
  Documentation for Unscramble.
  """

  @dict_path "/usr/share/dict/words"

  def parse(letters) do
    input_hash = make_hash(letters)

    dictionary_stream()
    |> Stream.map(fn word ->
      String.trim(word)
    end)
    |> Stream.filter(fn word ->
      suitable_candidate(word, letters) && hashes_are_equal(make_hash(word), input_hash)
    end)
    |> Enum.to_list()
  end

  def dictionary_stream() do
    File.stream!(@dict_path)
  end

  def make_hash(letters) do
    make_hash(String.split(letters, "", trim: true), %{})
  end

  def make_hash(["\n"|tail], acc), do: make_hash(tail, acc)

  def make_hash([head|tail], acc) do
    cond do
      Map.has_key?(acc, head) ->
        make_hash(tail, Map.put(acc, head, acc[head] + 1))
      true ->
        make_hash(tail, Map.put(acc, head, 1))
    end
  end

  def make_hash([], acc), do: acc

  def suitable_candidate(word, letters) do
    String.length(word) == String.length(letters) && String.contains?(letters, String.first(word))
  end

  def hashes_are_equal(hash, hash), do: true
  def hashes_are_equal(_a, _b), do: false
end
