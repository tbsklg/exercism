const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    for (dna) |n| {
        const c: u8 = switch (n) {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => unreachable,
        };

        try result.append(allocator, c);
    }

    return result.toOwnedSlice(allocator);
}
