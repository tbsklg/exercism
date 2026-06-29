const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    if (str.len == 0) return false;

    const alphabet: []const u8 = "abcdefghijklmnopqrstuvwxyz";

    var lower_buf: [256]u8 = undefined;
    const limit = if (str.len > lower_buf.len) lower_buf.len else str.len;
    const lower = lower_buf[0..limit];

    for (str[0..limit], 0..) |s, i| {
        lower[i] = std.ascii.toLower(s);
    }

    for (alphabet) |a| {
        if (std.mem.containsAtLeast(u8, lower, 1, &.{a})) continue else return false;
    }

    return true;
}
