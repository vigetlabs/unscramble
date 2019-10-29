extern crate phf;
use std::env;

include!(concat!(env!("OUT_DIR"), "/codegen.rs"));

fn main() {
  let word = &env::args().collect::<Vec<String>>()[1];
  let mut chars: Vec<char> = word.chars().collect();
  chars.sort_unstable();
  let sorted: String = chars.iter().collect();

  println!("{}", WORD.get(sorted.as_str()).unwrap());
}
