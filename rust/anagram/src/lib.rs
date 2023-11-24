use itertools::sorted;
use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    possible_anagrams
        .iter()
        .filter(|possible_anagram| is_anagram(word, possible_anagram))
        .copied()
        .collect()
}

fn is_anagram(word: &str, possible_anagram: &str) -> bool {
    let word = word.to_lowercase();
    let possible_anagram = possible_anagram.to_lowercase();

    if word == possible_anagram {
        return false;
    }

    let word = sorted(word.chars());
    let possible_anagram = sorted(possible_anagram.chars());

    word.eq(possible_anagram)
}
