use std::iter::repeat_n;

pub fn encode(source: &str) -> String {
    if source.is_empty() {
        return "".to_string();
    }

    let head = source.chars().next().unwrap();
    let capture = source.chars().take_while(|x| *x == head).count();
    let tail = source.chars().skip(capture).collect::<String>();

    if capture == 1 {
        return format!("{head}{}", encode(&tail));
    }

    format!("{}{head}{}", capture, encode(&tail))
}

pub fn decode(source: &str) -> String {
    if source.is_empty() {
        return String::new();
    }

    let head = source.chars().next().unwrap();

    if head.is_numeric() {
        let digits = source
            .chars()
            .take_while(|x| x.is_numeric())
            .collect::<String>();
        let count = digits.parse::<usize>().unwrap();
        let mut tail = source.chars().skip(digits.len());

        if let Some(repeat_char) = tail.next() {
            let decoded = repeat_n(repeat_char, count).collect::<String>();
            let remaining = tail.collect::<String>();
            return format!("{}{}", decoded, decode(&remaining));
        }
    }

    let tail = source.chars().skip(1).collect::<String>();
    format!("{}{}", head, decode(&tail))
}
