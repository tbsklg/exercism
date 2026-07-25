const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    if (s.len < 10) return false;
    var result: usize = 0;
    var factor: usize = 10;

    for (s) |c| switch (c) {
        '0'...'9' => {
            result += ((std.fmt.parseInt(usize, &.{c}, 10) catch unreachable) * factor);
            if (factor == 0) return false;
            factor -= 1;
        },
        'X' => result += 10,
        '-' => {},
        else => return false,
    };

    return result % 11 == 0;
}
