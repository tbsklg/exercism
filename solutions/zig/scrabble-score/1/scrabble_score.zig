const std = @import("std");

pub fn score(s: []const u8) u32 {
    var result: u32 = 0;

    for (s) |c| {
        const lower = std.ascii.toLower(c);
        result += switch (lower) {
            'q', 'z' => 10,
            'j', 'x' => 8,
            'k' => 5,
            'f', 'h', 'v', 'w', 'y' => 4,
            'b', 'c', 'm', 'p' => 3,
            'd', 'g' => 2,
            'a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't' => 1,
            else => 0,
        };
    }

    return result;
}
