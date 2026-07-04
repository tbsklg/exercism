const std = @import("std");

pub fn abbreviate(alloc: std.mem.Allocator, words: []const u8) std.mem.Allocator.Error![]u8 {
    var acronym: std.ArrayList(u8) = .empty;
    errdefer acronym.deinit(alloc);

    var iter = std.mem.tokenizeAny(u8, words, " -_");

    while (iter.next()) |p| {
        try acronym.append(alloc, std.ascii.toUpper(p[0]));
    }

    return acronym.toOwnedSlice(alloc);
}
