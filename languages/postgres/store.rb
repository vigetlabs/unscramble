#!/usr/bin/env ruby

require 'pg'

@db = PG.connect(dbname: 'unscramble')

def insert_node(letter, parent_node_id)
  @db.exec(
    "SELECT findOrCreate('#{letter}', #{parent_node_id.nil? ? 'NULL' : parent_node_id})"
  ).first["findorcreate"]
end

def save_word(node_id, word)
  existing = @db.exec(
    "SELECT word FROM nodes WHERE id = #{node_id}"
  ).first["word"]

  new_word = existing ? "#{existing},#{word}" : word
  @db.exec(
    "UPDATE nodes SET word = '#{new_word}' WHERE id = #{node_id}"
  )
end

words = File.read("/usr/share/dict/words").split("\n")
count = words.count
words.each_with_index do |word, index|
  print "   \r#{index + 1} / #{count}"

  last_node_id = nil
  word.chars.sort.each do |letter|
    last_node_id = insert_node(letter, last_node_id)
  end
  save_word(last_node_id, word)
end
puts
