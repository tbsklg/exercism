pub fn find(array: &[i32], key: i32) -> Option<usize> {
    if array.is_empty() {
        return None;
    }

    fn search(xs: Vec<(usize, &i32)>, key: i32) -> Option<usize> {
        let middle = xs.len() / 2;

        if xs.len() == 1 && *xs[middle].1 != key {
            return None;
        }

        if *xs[middle].1 == key {
            return Some(xs[middle].0);
        }

        if *xs[middle].1 > key {
            return search(xs[..middle].to_vec(), key);
        }

        if *xs[middle].1 < key {
            return search(xs[middle..].to_vec(), key);
        }

        None
    }

    search(array.iter().enumerate().collect::<Vec<_>>(), key)
}
