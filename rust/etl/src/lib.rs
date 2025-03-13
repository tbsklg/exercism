use std::collections::BTreeMap;

pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h.iter().fold(BTreeMap::new(), |mut acc, (k, v)| {
        for p in v {
            p.to_lowercase()
                .next()
                .and_then(|new_key| acc.insert(new_key, *k));
        }

        acc
    })
}
