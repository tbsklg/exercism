/// Compute the Scrabble score for a word.
pub fn score(word: &str) -> u64 {
    word.chars()
        .map(|c| c.to_ascii_lowercase())
        .fold(0, |mut acc, c| {
            if c == 'a'
                || c == 'e'
                || c == 'i'
                || c == 'o'
                || c == 'u'
                || c == 'l'
                || c == 'r'
                || c == 's'
                || c == 't'
                || c == 'n'
            {
                acc += 1;
            } else if c == 'd' || c == 'g' {
                acc += 2;
            } else if c == 'b' || c == 'c' || c == 'm' || c == 'p' {
                acc += 3;
            } else if c == 'f' || c == 'h' || c == 'v' || c == 'w' || c == 'y' {
                acc += 4;
            } else if c == 'k' {
                acc += 5;
            } else if c == 'x' || c == 'j' {
                acc += 8;
            } else if c == 'z' || c == 'q' {
                acc += 10;
            }
            acc
        })
}
