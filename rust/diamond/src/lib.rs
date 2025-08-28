use std::iter::repeat_n;

pub fn get_diamond(c: char) -> Vec<String> {
    if c == 'A' {
        return vec!["A".to_string()];
    }

    vec![first_line(c), middle_line(c), first_line(c)]
}

fn first_line(c: char) -> String {
    let whitespaces = repeat_n(' ', alphabet_position(c)).collect::<String>();
    format!("{}A{}", whitespaces, whitespaces)
}

fn middle_line(c: char) -> String {
    let whitespaces = repeat_n(' ', alphabet_position(c)).collect::<String>();
    format!("{}{}{}", c, whitespaces, c)
}

fn alphabet_position(c: char) -> usize {
    (c as u8 - b'A') as usize
}
