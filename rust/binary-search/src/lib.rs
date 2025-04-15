pub fn find(array: &[i32], key: i32) -> Option<usize> {
    if array.is_empty() {
        return None;
    }

    fn binary_search(slice: &[i32], key: i32, offset: usize) -> Option<usize> {
        if slice.is_empty() {
            return None;
        }

        let mid_idx = slice.len() / 2;
        let mid_val = slice[mid_idx];

        match mid_val.cmp(&key) {
            std::cmp::Ordering::Equal => Some(offset + mid_idx),
            std::cmp::Ordering::Greater => binary_search(&slice[..mid_idx], key, offset),
            std::cmp::Ordering::Less => {
                binary_search(&slice[mid_idx + 1..], key, offset + mid_idx + 1)
            }
        }
    }

    binary_search(array, key, 0)
}
