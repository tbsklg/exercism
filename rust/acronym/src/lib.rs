pub fn abbreviate(phrase: &str) -> String {
    fn get_word_start_indices(word: &str) -> Vec<usize> {
        word.chars()
            .enumerate()
            .filter(|&(i, c)| {
                i == 0
                    || c.is_uppercase()
                        && word
                            .chars()
                            .nth(i - 1)
                            .is_some_and(|prev| prev.is_lowercase())
            })
            .map(|(i, _)| i)
            .collect()
    }

    phrase
        .split([' ', '-', '_'])
        .filter(|word| !word.is_empty())
        .flat_map(|word| {
            get_word_start_indices(word)
                .into_iter()
                .filter_map(|i| word.chars().nth(i))
        })
        .map(|c| c.to_uppercase().next().unwrap())
        .collect()
}
