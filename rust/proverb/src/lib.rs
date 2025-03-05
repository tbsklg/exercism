pub fn build_proverb(l: &[&str]) -> String {
    if l.is_empty() {
        return String::new();
    }

    let mut phrases = l.windows(2).fold(vec![],
        |mut acc, curr| {
            let phrase = lost_for(curr[0], curr[1]);
            acc.push(phrase);
            acc
        },
    );

    phrases.push(end(l[0]));
    phrases.join("\n")
}

fn lost_for(x: &str, y: &str) -> String {
    format!("For want of a {x} the {y} was lost.")
}

fn end(x: &str) -> String {
    format!("And all for the want of a {x}.")
}
