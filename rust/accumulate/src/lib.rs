pub fn map<F, T, U>(input: Vec<T>, mut function: F) -> Vec<U>
where
    F: FnMut(T) -> U,
{
    input.into_iter().fold(vec![], |mut acc, curr| {
        acc.push(function(curr));
        acc
    })
}
