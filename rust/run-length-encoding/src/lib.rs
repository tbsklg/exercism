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
    todo!("Return the run-length decoding of {source}.");
}
