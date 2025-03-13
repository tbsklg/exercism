use std::collections::BTreeMap;

pub fn transform(h: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    h.iter().fold(BTreeMap::new(), |mut acc, (k, v)| {
        for p in v {
            acc.insert(p.to_ascii_lowercase(), *k);
        }

        acc
    })
}
