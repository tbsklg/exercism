const std = @import("std");

pub fn convert(buffer: []u8, x: u32) []const u8 {
    var i: usize = 0;
    var match = false;

    const pling = "Pling";
    const plang = "Plang";
    const plong = "Plong";

    if (x % 3 == 0) {
        match = true;
        @memcpy(buffer[i .. i + pling.len], pling);
        i += pling.len;
    }

    if (x % 5 == 0) {
        match = true;
        @memcpy(buffer[i .. i + plang.len], plang);
        i += plang.len;
    }

    if (x % 7 == 0) {
        match = true;
        @memcpy(buffer[i .. i + plong.len], plong);
        i += plong.len;
    }

    if (!match) {
        const str = std.fmt.bufPrint(buffer, "{}", .{x}) catch unreachable;
        i += str.len;
    }

    return buffer[0..i];
}
