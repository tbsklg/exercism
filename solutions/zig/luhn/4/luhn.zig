const std = @import("std");

pub fn isValid(xs: []const u8) bool {
    var sum: usize = 0;
    var pos: usize = 0;

    var iter = std.mem.reverseIterator(xs);

    while (iter.next()) |x| {
        if (std.ascii.isWhitespace(x)) continue;

        const maybeDigit = std.fmt.charToDigit(x, 10) catch return false;

        if (pos % 2 == 0) {
            sum += maybeDigit;
            pos += 1;
            continue;
        }

        const double = maybeDigit * 2;
        sum += if (double > 9) double - 9 else double;
        pos += 1;
    }

    return pos > 1 and sum % 10 == 0;
}
