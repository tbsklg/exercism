const std = @import("std");

pub fn clean(phrase: []const u8) ?[10]u8 {
    var number: [10]u8 = undefined;

    var i: usize = 0;
    for (phrase) |x| {
        if (std.ascii.isDigit(x)) {
            if (i == 0 and x == '0') return null;
            if (i == 0 and x == '1') continue;
            if (i == 3 and (x == '0' or x == '1')) return null;
            if (i == 10) return null;
            number[i] = x;
            i += 1;
        }
    }

    if (i < 10) return null;

    return number;
}
