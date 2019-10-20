defmodule Unscramble do
  @dict_path "/usr/share/dict/words"

  @moduledoc """
  Documentation for Unscramble.
  """
  def parse(letters) do
    dets_parse(letters)
  end

  def dets_parse(letters) do

    # if dictionary has been hashed
    if (:dets.is_dets_file(:dictionary)) do
      :dets.open_file(:dictionary, [type: :set])
      make_hash(letters) |> dets_lookup()
    else
      dets_dictionary!()
      dets_parse(letters)
    end
  end

  def dets_lookup(hash) do
    :dets.match(:dictionary, {hash, :"$1"})
    |> hd
  end

  def dets_dictionary!() do
    :dets.open_file(:dictionary, [type: :set])
    stream_dictionary()
    |> Stream.each(fn word -> 
      :dets.insert_new(:dictionary, {make_hash(word), word |> String.trim()})
    end)
    |> Stream.run()
  end

  def stream_parse(letters) do
    input = make_hash(letters)
    stream_dictionary() |> Stream.drop_while(fn word ->
      input !== word |> make_hash
    end)
    |> Enum.take(1)
    |> hd
    |> String.trim()
  end

  def make_hash(letters) do
    letters
    |> String.trim()
    |> String.split("", trim: true)
    |> make_hash(%{})
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
    File.read!(@dict_path)
    |> String.split("\n")
  end

  def stream_dictionary() do
    File.stream!(@dict_path)
  end
end
