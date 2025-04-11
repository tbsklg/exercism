pub fn is_valid(code: &str) -> bool {
    let digits: Vec<u32> = code
        .chars()
        .filter(|c| !c.is_whitespace())
        .map(|c| c.to_digit(10))
        .collect::<Option<Vec<u32>>>()
        .unwrap_or_default();

    digits.len() > 1 && 
    digits.len() == code.chars().filter(|c| !c.is_whitespace()).count() &&
    digits
        .iter()
        .rev()
        .enumerate()
        .map(|(i, &digit)| {
            if i % 2 == 1 {
                let doubled = digit * 2;
                if doubled > 9 { doubled - 9 } else { doubled }
            } else {
                digit
            }
        })
        .sum::<u32>() % 10 == 0
}
