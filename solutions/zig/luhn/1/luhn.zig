const std = @import("std");

pub fn isValid(xs: []const u8) bool {
    var sum: usize = 0;
    var dig: usize = 0;

    for (0..xs.len) |i| {
        const j = xs.len - 1 - i;
        if (std.ascii.isWhitespace(xs[j])) continue;

        const d = std.fmt.charToDigit(xs[j], 10) catch return false;

        if (dig % 2 == 0) {
            sum += d;
            dig += 1;
            continue;
        }

        const dt = if (d * 2 > 9) d * 2 - 9 else d * 2;
        sum += dt;
        dig += 1;
    }

    if (dig <= 1) return false;

    return sum % 10 == 0;
}
