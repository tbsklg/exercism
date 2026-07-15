const std = @import("std");
const mem = std.mem;

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var words = std.BufSet.init(allocator);
    errdefer words.deinit();

    const lower_word = try std.ascii.allocLowerString(allocator, word);
    defer allocator.free(lower_word);

    for (candidates) |candidate| blk: {
        if (candidate.len != word.len) continue;

        const lower_candidate = try std.ascii.allocLowerString(allocator, candidate);
        defer allocator.free(lower_candidate);

        if (mem.eql(u8, lower_candidate, lower_word)) continue;

        for (lower_word) |c| {
            if (count(lower_word, c) != count(lower_candidate, c)) break :blk;
        }

        try words.insert(candidate);
    }

    return words;
}

fn count(word: []const u8, c: u8) u8 {
    var result: u8 = 0;

    for (word) |w| {
        if (w == c) result += 1;
    }

    return result;
}
