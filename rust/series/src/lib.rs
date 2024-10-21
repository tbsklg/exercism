pub fn series(digits: &str, len: usize) -> Vec<String> {
    let mut r = vec![];

    if len > digits.len() {
        return r;
    }

    for i in 0..=digits.len() - len {
        r.push(digits[i..i + len].to_string());
    }

    return r;
}
