const std = @import("std");

pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    if (digits.len < span) return SeriesError.InsufficientDigits;
    if (digits.len == 0 and span == 0) return 1;
    if (digits.len > 0 and span == 0) return 1;
    if (span < 0) return SeriesError.NegativeSpan;

    var iter = std.mem.window(u8, digits, @as(usize, @intCast(span)), 1);

    var largest: u64 = 0;
    while (iter.next()) |xs| {
        var sum: u64 = 1;

        for (xs) |x| {
            const d = try std.fmt.charToDigit(x, 10);
            sum *= d;
        }

        if (sum > largest) largest = sum;
    }

    return largest;
}
