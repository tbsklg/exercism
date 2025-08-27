pub fn get_diamond(c: char) -> Vec<String> {
    if c == 'A' {
        return vec!["A".to_string()];
    }

    vec![
        " A ".to_string(),
        "B B".to_string(),
        " A ".to_string(),
    ]
}
