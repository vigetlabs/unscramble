extern crate phf_codegen;

use std::collections::HashSet;
use std::env;
use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;
use std::io::BufWriter;
use std::io::Write;
use std::path::Path;

fn main() {
    let path = Path::new(&env::var("OUT_DIR").unwrap()).join("codegen.rs");
    let mut file = BufWriter::new(File::create(&path).unwrap());
    let mut word_set = HashSet::new();

    write!(
        &mut file,
        "static WORD: phf::Map<&'static str, &'static str> = "
    )
    .unwrap();

    let mut map = phf_codegen::Map::<&str>::new();

    let dict_file = File::open("/usr/share/dict/words").unwrap();
    let mut reader = BufReader::new(dict_file);

    for line in reader.lines() {
        let line = line.unwrap();
        let mut chars = line.chars().collect::<Vec<char>>();
        chars.sort_unstable();
        let sorted_line: String = chars.iter().collect();
        if !word_set.contains(&sorted_line) {
            word_set.insert(sorted_line.clone());
            map.entry(
                Box::leak(sorted_line.into_boxed_str()),
                Box::leak(format!("\"{}\"", line).into_boxed_str()),
            );
        }
    }

    writeln!(&mut file, "{};\n", map.build()).unwrap();
}
