const std = @import("std");

pub const HighScores = struct {
    scores: []const i32,

    pub fn init(scores: []const i32) HighScores {
        return .{
            .scores = scores,
        };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        return self.scores[self.scores.len - 1];
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        return self.scores[std.mem.findMax(i32, self.scores)];
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        const allocator = std.heap.page_allocator;
        const copy = allocator.dupe(i32, self.scores) catch
            unreachable;
        std.mem.sort(i32, copy, {}, std.sort.desc(i32));
        return copy[0..@min(3, copy.len)];
    }
};
