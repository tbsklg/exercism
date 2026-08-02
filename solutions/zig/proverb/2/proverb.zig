const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    var rhyme: std.ArrayList([]u8) = .empty;

    errdefer {
        for (rhyme.items) |line| allocator.free(line);
        rhyme.deinit(allocator);
    }

    var i: usize = 0;
    while (i + 1 < words.len) : (i += 1) {
        const line = try fmt.allocPrint(
            allocator,
            "For want of a {s} the {s} was lost.\n",
            .{ words[i], words[i + 1] },
        );
        errdefer allocator.free(line);
        try rhyme.append(allocator, line);
    }

    if (words.len > 0) {
        const last = try fmt.allocPrint(
            allocator,
            "And all for the want of a {s}.\n",
            .{words[0]},
        );
        errdefer allocator.free(last);
        try rhyme.append(allocator, last);
    }

    return rhyme.toOwnedSlice(allocator);
}
