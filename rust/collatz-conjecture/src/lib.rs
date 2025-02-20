pub fn collatz(n: u64) -> Option<u64> {
    fn count_steps(n: u64, steps: u64) -> Option<u64> {
        match n {
            0 => None,
            1 => Some(steps),
            n => match n % 2 {
                0 => n.checked_div(2).and_then(|n| count_steps(n, steps + 1)),
                _ => n
                    .checked_mul(3)
                    .and_then(|n| n.checked_add(1))
                    .and_then(|n| count_steps(n, steps + 1)),
            },
        }
    }

    match n {
        0 => None,
        n => count_steps(n, 0),
    }
}
