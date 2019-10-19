defmodule Unscramble.Cache do
  @cache_table :word_pairs
  @cache_file_path Path.join(File.cwd!(), "unscramble.tab")
  @ets_args [:named_table, :duplicate_bag]

  import Unscramble.Helpers, only: [tuple_from_word: 1]

  def initialize_cache() do
    create_persistent_table()
    populate_cache_if_empty()
  end

  def clear_cache() do
    PersistentEts.delete(@cache_table)
  end

  def create_persistent_table() do
    PersistentEts.new(@cache_table, @cache_file_path, @ets_args)
  end

  def find(word) do
    :ets.lookup(@cache_table, tuple_from_word(word))
  end

  def populate_cache_if_empty() do
    case populated?() do
      true  -> nil
      false -> insert_data()
    end
  end

  def insert_data() do
    File.read!("/usr/share/dict/words")
    |> String.split("\n")
    |> Enum.each(fn word ->
      key = tuple_from_word(word)
      :ets.insert(@cache_table, {key, word})
    end)
  end

  def populated?() do
    case :ets.info(@cache_table, :size) do
      :undefined -> false
      size       -> size > 0
    end
  end
end
