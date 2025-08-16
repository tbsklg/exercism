/// Compute the Scrabble score for a word.
pub fn score(word: &str) -> u64 {
    word.chars()
        .map(|c| c.to_ascii_lowercase())
        .fold(0, |mut acc, c| {
            if c == 'z' {
                acc += 10;
            }

            if c == 'o' {
                acc += 1;
            }

            if c == 'f' {
                acc += 4;
            }

            if c == 'a' || c == 't' || c == 's' || c == 'r' || c == 'e' {
                acc += 1;
            }

            acc
        })
}
