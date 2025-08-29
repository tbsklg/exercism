pub fn get_diamond(c: char) -> Vec<String> {
    if c == 'A' {
        return vec!["A".to_string()];
    }

    let mut result = Vec::new();
    let target_pos = alphabet_position(c);

    result.push(line('A', target_pos, 0));

    for i in 1..=target_pos {
        let current_char = (b'A' + i as u8) as char;
        result.push(line(current_char, target_pos, i));
    }

    for i in (0..target_pos).rev() {
        let current_char = (b'A' + i as u8) as char;
        result.push(line(current_char, target_pos, i));
    }

    result
}

fn line(c: char, target_pos: usize, pos: usize) -> String {
    if c == 'A' {
        let outer = " ".repeat(target_pos - pos);
        return format!("{}A{}", outer, outer);
    }

    let outer = " ".repeat(target_pos - pos);
    let inner = " ".repeat(pos * 2 - 1);
    format!("{}{}{}{}{}", outer, c, inner, c, outer)
}

fn alphabet_position(c: char) -> usize {
    (c as u8 - b'A') as usize
}
