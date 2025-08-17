/// Compute the Scrabble score for a word.
pub fn score(word: &str) -> u64 {
    word.chars()
        .map(|c| c.to_ascii_lowercase())
        .fold(0, |mut acc, c| {
            if c == 'a' || c == 't' || c == 's' || c == 'r' || c == 'e' || c == 'u' || c == 'i' || c == 'o' {
                acc += 1;
            }

            if c == 'f' || c == 'y' {
                acc += 4;
            }

            if c == 'k' {
                acc += 5;
            }

            if c == 'z' || c == 'q' {
                acc += 10;
            }

            acc
        })
}
