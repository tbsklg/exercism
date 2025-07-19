pub fn encode(content: &str) -> String {
    if content.is_empty() {
        return String::new();
    }

    let mut result = String::with_capacity(content.len());
    let mut chars = content.chars().peekable();

    while let Some(curr) = chars.next() {
        let mut count = 1;

        while chars.peek() == Some(&curr) {
            count += 1;
            chars.next();
        }

        if count > 1 {
            result.push_str(&count.to_string());
        }
        result.push(curr);
    }

    result
}

pub fn decode(content: &str) -> String {
    if content.is_empty() {
        return String::new();
    }

    let mut result = String::with_capacity(content.len() * 2);
    let mut chars = content.chars().peekable();

    while let Some(curr) = chars.next() {
        if curr.is_ascii_digit() {
            let mut numeric_chars = String::new();
            numeric_chars.push(curr);

            while let Some(&next_char) = chars.peek() {
                if next_char.is_ascii_digit() {
                    numeric_chars.push(chars.next().unwrap());
                } else {
                    break;
                }
            }

            if let Some(repeat_char) = chars.next() {
                if let Ok(count) = numeric_chars.parse::<usize>() {
                    result.push_str(&repeat_char.to_string().repeat(count));
                } else {
                    result.push_str(&numeric_chars);
                    result.push(repeat_char);
                }
            } else {
                result.push_str(&numeric_chars);
            }
        } else {
            result.push(curr);
        }
    }

    result
}
