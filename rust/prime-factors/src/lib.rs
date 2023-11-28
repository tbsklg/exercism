pub fn factors(mut n: u64) -> Vec<u64> {
    let mut candidates = 2..;
    let mut factors = Vec::new();

    while n > 1 {
        let candidate = candidates.next().unwrap();

        while n % candidate == 0 {
            n /= candidate;
            factors.push(candidate);
        }
    }

    factors
}
