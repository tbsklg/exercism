const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    if (num == 0) return true;

    const digits = std.math.log10_int(num) + 1;

    var result: u128 = 0;
    var n = num;
    while (n > 0) : (n /= 10) {
        result += std.math.pow(u128, n % 10, digits);
    }

    return result == num;
}
