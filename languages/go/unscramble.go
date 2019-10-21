package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

const dictFilePath = "/usr/share/dict/words"

type Word struct {
	Value string

	_normalized *string
}

func NewWord(value string) *Word {
	return &Word{Value: value}
}

func (w *Word) Equals(compare *Word) bool {
	equal := len(w.Value) == len(compare.Value)
	equal = equal && w.normalized() == compare.normalized()

	return equal
}

func (w *Word) normalized() string {
	if w._normalized == nil {
		chars := strings.Split(w.Value, "")
		sort.Strings(chars)
		joined := strings.Join(chars, "")

		w._normalized = &joined
	}

	return *w._normalized
}

func main() {
	if len(os.Args) != 2 {
		fmt.Printf("Usage: %s <word>\n", os.Args[0])
		os.Exit(1)
	}

	file, err := os.Open(dictFilePath)

	if err != nil {
		fmt.Printf("Error: %s\n", err.Error())
		os.Exit(1)
	}

	defer file.Close()

	scrambled := NewWord(os.Args[1])

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		word := NewWord(scanner.Text())

		if scrambled.Equals(word) {
			fmt.Println(word.Value)
			os.Exit(0)
		}
	}
}
