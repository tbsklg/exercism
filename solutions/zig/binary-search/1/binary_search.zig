// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    if (items.len == 0) return null;
    const middle = items.len / 2;

    const item = items[middle];
    if (item == target) return middle;
    if (item > target) return binarySearch(T, target, items[0..middle]);
    if (binarySearch(T, target, items[middle + 1 ..])) |b| {
        return middle + 1 + b;
    }
    return null;
}
