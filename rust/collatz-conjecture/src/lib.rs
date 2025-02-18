pub fn collatz(n: u64) -> Option<u64> {
    fn count_steps(n: u64, steps: u64) -> u64 {
        let even = |n: u64| n % 2 == 0;

        if n == 1 {
            return steps;
        }

        if even(n) {
            return count_steps(n / 2, steps + 1);
        }

        count_steps(n * 3 + 1, steps + 1)
    }

    if n == 0 {
        return None;
    }

    Some(count_steps(n, 0))
}
