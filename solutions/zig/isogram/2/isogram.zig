const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var buffer: [26]u8 = undefined;

    for (str, 0..) |c, i| {
        if (!std.ascii.isAlphabetic(c)) continue;

        const lower = std.ascii.toLower(c);
        if (std.mem.containsAtLeast(u8, &buffer, 1, &.{lower})) return false;

        buffer[i] = lower;
    }

    return true;
}
