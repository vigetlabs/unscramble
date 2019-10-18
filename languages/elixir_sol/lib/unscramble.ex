defmodule Unscramble do
  @moduledoc """
  Documentation for Unscramble.
  """
  def parse(letters) do
    input = make_hash(letters)
    dictionary_stream() |> Stream.drop_while(fn word ->
      input !== word |> String.trim() |> make_hash
    end)
    |> Enum.take(1)
    |> hd
    |> String.trim()
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

  def dictionary_stream() do
    File.stream!("/usr/share/dict/words")
  end
end
