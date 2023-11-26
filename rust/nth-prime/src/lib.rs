pub fn nth(n: u32) -> u32 {
    (2..).filter(|x| is_prime(x)).nth(n as usize).unwrap()
}

fn is_prime(n: &u32) -> bool {
    (2..=((*n as f64).sqrt() as u32)).all(|x| (n % x) != 0)
}
