const std = @import("std");

pub fn squareOfSum(n: usize) usize {
    return std.math.pow(usize, (n * (n + 1)) / 2, 2);
}

pub fn sumOfSquares(n: usize) usize {
    var sum: usize = 0;
    for (1..n + 1) |i| {
        sum += std.math.pow(usize, i, 2);
    }

    return sum;
}

pub fn differenceOfSquares(number: usize) usize {
    return squareOfSum(number) - sumOfSquares(number);
}
