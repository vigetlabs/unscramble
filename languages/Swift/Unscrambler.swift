import Foundation

let DEBUG_MODE = false

class Unscrambler {

    // MARK: - Permutations

    private static func calculatePermutations(for word: String) -> Set<String> {
        var set = Set<String>()
        permutation(for: word, set: &set)
        return set
    }

    // This is SLOW... O(n!)
    private static func permutation(for word: String, prefix: String = "", set: inout Set<String>) {
        if word.count == 0 {
            set.insert(prefix)
        }

        for i in word.indices {
            let left = String(word[..<i])
            let right = word[word.index(after: i)...]

            let remainder = left + right
            permutation(for: remainder, prefix: prefix + String(word[i]), set: &set)
        }

        if DEBUG_MODE {
            print("Set:")
            print(set)
            print("\n")
        }
    }

    // MARK: - Lexicographical Sorting

    private static func normalize(_ word: String) -> String {
        return String(word.sorted())
    }

    static func unscramble(word: String) -> String {
        let path = "/usr/share/dict/words"
        let encoding = String.Encoding.utf8.rawValue

        guard let lookupTable = try? NSString(contentsOfFile: path, encoding: encoding) else {
            fatalError("Unable to find a lookup dictionary. Ensure that \(path) exists.")
        }

        var matchedWord: String = ""
        let possibleWords = lookupTable.components(separatedBy: "\n").filter { word.count == $0.count }

        possibleWords.forEach {
            let sortedWord = Unscrambler.normalize(word)

            if sortedWord == Unscrambler.normalize($0) {
                matchedWord = $0
                return
            }
        }

        return matchedWord
    }

}

print(Unscrambler.unscramble(word: CommandLine.arguments[1]))
