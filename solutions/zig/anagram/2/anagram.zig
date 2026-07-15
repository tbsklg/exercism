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

    const count_word = count(lower_word);

    for (candidates) |candidate| {
        if (candidate.len != word.len) continue;

        const lower_candidate = try std.ascii.allocLowerString(allocator, candidate);
        defer allocator.free(lower_candidate);

        if (mem.eql(u8, lower_candidate, lower_word)) continue;

        const count_candidate = count(lower_candidate);

        if (!mem.eql(u8, &count_word, &count_candidate)) continue;

        try words.insert(candidate);
    }

    return words;
}

fn count(word: []const u8) [26]u8 {
    var buffer: [26]u8 = .{0} ** 26;

    for (word) |c| {
        buffer[c - 'a'] += 1;
    }

    return buffer;
}
