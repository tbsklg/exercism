const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var seen: u32 = 0;

    for (str) |c| {
        if (!std.ascii.isAlphabetic(c)) continue;

        const bit: u32 = @as(u32, 1) << @intCast(std.ascii.toLower(c) - 'a');
        if (seen & bit != 0) return false;

        seen |= bit;
    }

    return true;
}
