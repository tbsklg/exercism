pub fn encode(source: &str) -> String {
    if source.is_empty() {
        return "".to_string();
    }

    let head = source.chars().next().unwrap();
    let count = source.chars().take_while(|x| *x == head).count();

    let encoded = match count {
        1 => format!("{head}"),
        _ => format!("{}{}", count, head),
    };

    let tail = source
        .chars()
        .skip_while(|x| *x == head)
        .collect::<String>();

    format!("{}{}", encoded, encode(&tail))
}

pub fn decode(source: &str) -> String {
    todo!("Return the run-length decoding of {source}.");
}
