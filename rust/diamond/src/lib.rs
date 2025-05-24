pub fn get_diamond(c: char) -> Vec<String> {
    if c == 'A' {
        return vec!["A".to_string()];
    }
    
    let n = (c as u8 - b'A') as usize;
    let width = 2 * n + 1;
    let mut result = Vec::new();
    
    for i in 0..=n {
        let letter = (b'A' + i as u8) as char;
        let outer_spaces = n - i;
        
        if i == 0 {
            let line = format!("{}{}{}", 
                " ".repeat(outer_spaces), 
                letter, 
                " ".repeat(outer_spaces)
            );
            result.push(line);
        } else {
            let inner_spaces = 2 * i - 1;
            let line = format!("{}{}{}{}{}", 
                " ".repeat(outer_spaces), 
                letter, 
                " ".repeat(inner_spaces), 
                letter, 
                " ".repeat(outer_spaces)
            );
            result.push(line);
        }
    }
    
    for i in (0..n).rev() {
        let letter = (b'A' + i as u8) as char;
        let outer_spaces = n - i;
        
        if i == 0 {
            let line = format!("{}{}{}", 
                " ".repeat(outer_spaces), 
                letter, 
                " ".repeat(outer_spaces)
            );
            result.push(line);
        } else {
            let inner_spaces = 2 * i - 1;
            let line = format!("{}{}{}{}{}", 
                " ".repeat(outer_spaces), 
                letter, 
                " ".repeat(inner_spaces), 
                letter, 
                " ".repeat(outer_spaces)
            );
            result.push(line);
        }
    }
    
    result
}
