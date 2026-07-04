const std = @import("std");

pub fn abbreviate(alloc: std.mem.Allocator, words: []const u8) std.mem.Allocator.Error![]u8 {
    var acronym: std.ArrayList(u8) = .empty;
    errdefer acronym.deinit(alloc);

    var iter = std.mem.splitAny(u8, words, " -_");

    while (iter.next()) |p| {
        if (p.len == 0) continue;

        const upper = std.ascii.toUpper(p[0]);
        try acronym.append(alloc, upper);
    }

    return acronym.toOwnedSlice(alloc);
}
