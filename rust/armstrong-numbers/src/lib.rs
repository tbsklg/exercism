pub fn is_armstrong_number(num: u32) -> bool {
    let digits: Vec<u64> = num
        .to_string()
        .chars()
        .map(|d| d.to_digit(10).unwrap() as u64)
        .collect();

    return num as u64 == digits.iter().map(|d| d.pow(digits.len() as u32)).sum();
}
