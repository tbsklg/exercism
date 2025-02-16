pub fn reply(message: &str) -> &str {
    let message = message.trim();

    silence(message)
        .or_else(|| yell_question(message))
        .or_else(|| all_capital_letters(message))
        .or_else(|| ends_with_question_mark(message))
        .unwrap_or("Whatever.")
}

fn silence(message: &str) -> Option<&str> {
    if message.is_empty() {
        Some("Fine. Be that way!")
    } else {
        None
    }
}

fn all_capital_letters(message: &str) -> Option<&str> {
    let letters = message
        .chars()
        .filter(|c| c.is_alphabetic())
        .collect::<Vec<_>>();

    if !letters.is_empty() && letters.iter().all(|c| c.is_uppercase()) {
        Some("Whoa, chill out!")
    } else {
        None
    }
}

fn ends_with_question_mark(message: &str) -> Option<&str> {
    if message.ends_with('?') {
        Some("Sure.")
    } else {
        None
    }
}

fn yell_question(message: &str) -> Option<&str> {
    if ends_with_question_mark(message).is_some() && all_capital_letters(message).is_some() {
        Some("Calm down, I know what I'm doing!")
    } else {
        None
    }
}
