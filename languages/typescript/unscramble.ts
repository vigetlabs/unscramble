const fs = require("fs")
const dictionary = fs.readFileSync("/usr/share/dict/words", "utf8")
  .split("\n")

const input = process.argv[2]

if (!input) {
  process.exit(1)
}

const getLetterCounts = (word) => {
  const counts = {}

  word.split("").forEach((letter) => {
    const letterKey = letter.toLowerCase()
    if (counts[letterKey]) {
      counts[letterKey]++
    } else {
      counts[letterKey] = 1
    }
  })

  return counts
}

const inputLetterCounts = getLetterCounts(input)

const match = dictionary.find((word) => {
  if (word.length !== input.length) {
    return false
  }

  const wordLetterCounts = getLetterCounts(word)

  return Object.keys(wordLetterCounts).every((key) => (
    inputLetterCounts[key] === wordLetterCounts[key]
  ))
})

console.log(match)
