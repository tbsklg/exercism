const std = @import("std");

pub const HighScores = struct {
    scores: []const i32,
    top3: [3]i32,
    top_len: usize,

    pub fn init(scores: []const i32) HighScores {
        var top3: [3]i32 = undefined;

        for (scores) |s| {
            if (s > top3[0]) {
                top3[2] = top3[1];
                top3[1] = top3[0];
                top3[0] = s;
                continue;
            }

            if (s > top3[1]) {
                top3[2] = top3[1];
                top3[1] = s;
                continue;
            }

            if (s > top3[2]) {
                top3[2] = s;
                continue;
            }
        }

        return .{
            .top3 = top3,
            .top_len = @min(3, scores.len),
            .scores = scores,
        };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        if (self.scores.len == 0) return null;
        return self.scores[self.scores.len - 1];
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        if (self.scores.len == 0) return null;
        return self.top3[0];
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.top3[0..self.top_len];
    }
};
