pub fn reply(message: &str) -> &str {
    let message = message.trim();
    
    let is_silence = |m: &str| m.is_empty();
    let is_yelling = |m: &str| has_letters(m) && m.chars().filter(|c| c.is_alphabetic()).all(|c| c.is_uppercase());
    let is_question = |m: &str| m.ends_with('?');
    
    match message {
        m if is_silence(m) => "Fine. Be that way!",
        m if is_yelling(m) && is_question(m) => "Calm down, I know what I'm doing!",
        m if is_yelling(m) => "Whoa, chill out!",
        m if is_question(m) => "Sure.",
        _ => "Whatever."
    }
}

fn has_letters(s: &str) -> bool {
    s.chars().any(|c| c.is_alphabetic())
}
