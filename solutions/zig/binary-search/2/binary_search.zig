// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    var upper = items.len;
    var lower: usize = 0;

    while (lower < upper) {
        const middle = (upper + lower) / 2;
        if (items[middle] == target) return middle;
        if (items[middle] > target) {
            upper = middle;
            continue;
        }

        lower = middle + 1;
    }

    return null;
}
