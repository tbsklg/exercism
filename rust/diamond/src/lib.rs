use std::iter::repeat_n;

pub fn get_diamond(c: char) -> Vec<String> {
    if c == 'A' {
        return vec![c.to_string()];
    }

    let first_line = first_line(c);
    let middle_line = middle_line(c);

    vec![
        first_line.to_string(),
        middle_line.to_string(),
        first_line.to_string(),
    ]
}

// TODO: why do i need the type here?
const ALPHABET: &str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

fn alphabet_index(c: char) -> usize {
    ALPHABET.find(c).unwrap()
}

fn first_line(c: char) -> String {
    let whitespaces = repeat_n(" ", alphabet_index(c)).collect::<String>();
    format!("{whitespaces}A{whitespaces}")
}

fn middle_line(c: char) -> String {
    let whitespaces = repeat_n(" ", alphabet_index(c)).collect::<String>();
    format!("{c}{whitespaces}{c}")
}
