pub fn egg_count(display_value: u32) -> usize {
    fn bits(n: u32, mut r: Vec<u32>) -> Vec<u32> {
        if n == 0 {
            return r;
        }

        r.push(n % 2);
        bits(n / 2, r)
    }

    bits(display_value, vec![])
        .iter()
        .filter(|n| **n == 1)
        .count()
}
