#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    let sublist = _first_list.is_empty()
        || _second_list
            .windows(_first_list.len())
            .any(|w| w == _first_list);

    let superlist = _second_list.is_empty()
        || _first_list
            .windows(_second_list.len())
            .any(|w| w == _second_list);

    match (sublist, superlist) {
        (true, true) => Comparison::Equal,
        (true, false) => Comparison::Sublist,
        (false, true) => Comparison::Superlist,
        (false, false) => Comparison::Unequal,
    }
}
