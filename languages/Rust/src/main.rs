use std::env;
use std::fs::File;
use std::io::{self, prelude::*, BufReader};

fn main() {
  let word = &env::args().collect::<Vec<String>>()[1];
  let matches: Vec<String> = get_matches(word).expect("Error reading words file");
  for s in matches.iter() {
    println!("{}", s);
  }
}

fn get_matches(word: &str) -> io::Result<Vec<String>> {
  let file = File::open("/usr/share/dict/words")?;
  let reader = BufReader::new(file);
  let mut vec: Vec<String> = Vec::new();
  let sorted_word = sort_chars(word);

  for line in reader.lines() {
    let line = line?;
    let mut line_chars = line.chars();
    if line.len() == sorted_word.len() && line_chars.any(|x| x == sorted_word[0]) {
      let sorted_line = sort_chars(&line);
      if sorted_line == sorted_word {
        vec.push(line.clone());
      }
    }
  }

  Ok(vec)
}

fn sort_chars(word: &str) -> Vec<char> {
  let mut chars: Vec<char> = word.chars().collect();
  chars.sort();
  chars
}
