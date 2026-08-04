const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    const result = try allocator.alloc(u8, text.len);

    for (text, 0..) |t, i| {
        if (!std.ascii.isAlphabetic(t)) {
            result[i] = t;
            continue;
        }

        const base: u8 = if (std.ascii.isUpper(t)) 'A' else 'a';
        result[i] = ((t - base + shiftKey) % 26) + base;
    }

    return result;
}
