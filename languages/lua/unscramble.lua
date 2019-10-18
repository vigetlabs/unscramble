dictionaryIterator = io.lines("/usr/share/dict/words")
input = arg[1]

if input == nil then
  os.exit()
end

function convertStringToArray(string)
  output = {}

  for index = 1, string.len(string) do
    output[index] = string.sub(string, index, index)
  end

  return output
end

function getLetterCounts(word)
  letters = convertStringToArray(word)
  counts = {}

  for index, letter in next, letters do
    letterKey = string.lower(letter)

    if counts[letterKey] ~= nil then
      counts[letterKey] = counts[letterKey] + 1
    else
      counts[letterKey] = 1
    end
  end

  return counts
end

inputLetterCounts = getLetterCounts(input)
match = nil

for word in dictionaryIterator do
  if string.len(word) == string.len(input) then
    wordLetterCounts = getLetterCounts(word)

    isMatch = true

    for letterKey, count in next, wordLetterCounts do
      if inputLetterCounts[letterKey] ~= wordLetterCounts[letterKey] then
        isMatch = false
        break
      end
    end

    if isMatch == true then
      match = word
      break
    end
  end
end

print(match)
