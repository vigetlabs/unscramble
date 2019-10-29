defmodule Unscramble.Cache do
  @cache_table :word_pairs
  @cache_file_path Path.join(File.cwd!(), "unscramble.tab")
  @ets_args [:named_table, :duplicate_bag]

  import Unscramble.Helpers, only: [tuple_from_word: 1]

  def initialize() do
    create_table()
    populate_if_empty()
  end

  def find(word) do
    :ets.lookup(@cache_table, tuple_from_word(word))
  end

  def clear() do
    case :ets.info(@cache_table) do
      :undefined -> nil
      _ -> PersistentEts.delete(@cache_table)
    end
  end

  # private

  defp create_table() do
    case :ets.info(@cache_table) do
      :undefined -> PersistentEts.new(@cache_table, @cache_file_path, @ets_args)
      _ -> nil
    end
  end

  defp populate_if_empty() do
    case populated?() do
      true -> nil
      false -> insert_data()
    end
  end

  defp insert_data() do
    File.read!("/usr/share/dict/words")
    |> String.split("\n")
    |> Enum.each(fn word ->
      key = tuple_from_word(word)
      :ets.insert(@cache_table, {key, word})
    end)
  end

  defp populated?() do
    case :ets.info(@cache_table, :size) do
      :undefined -> false
      size -> size > 0
    end
  end
end
