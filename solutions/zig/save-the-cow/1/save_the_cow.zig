const std = @import("std");
const mem = std.mem;

pub const State = enum {
    ongoing,
    win,
    lose,
};

pub const Error = error{ GameAlreadyWon, GameAlreadyLost };

pub const Game = struct {
    state: State,
    remaining_failures: u32,
    word: []const u8,
    masked: []u8,
    // Additional fields need to be added.

    /// Initializes a game with a copy of the given word, 9 remaining failures
    /// and every letter hidden.
    pub fn init(allocator: mem.Allocator, word: []const u8) mem.Allocator.Error!Game {
        const _word = try allocator.dupe(u8, word);
        errdefer allocator.free(_word);

        const masked = try allocator.alloc(u8, word.len);
        errdefer allocator.free(masked);
        @memset(masked, '_');

        return .{
            .state = .ongoing,
            .remaining_failures = 9,
            .word = _word,
            .masked = masked,
        };
    }

    /// Frees the game.
    pub fn deinit(self: *Game, allocator: mem.Allocator) void {
        allocator.free(self.word);
        allocator.free(self.masked);
    }    

    /// Processes one guessed letter.
    pub fn guess(self: *Game, letter: u8) Error!void {
        if (self.state == .lose) return Error.GameAlreadyLost;
        if (self.state == .win) return Error.GameAlreadyWon;

        var match = false;
        for (0..self.word.len) |i| {
            if (self.word[i] == letter and self.masked[i] != letter) {
                self.masked[i] = letter;
                match = true;
            }
        }

        if (std.mem.eql(u8, self.word, self.masked)) {
            self.state = .win;
            return;
        }

        if (match) return;

        if (self.remaining_failures == 0) {
            self.state = .lose;
            return;
        }

        self.remaining_failures -= 1;
    }

    /// Returns the word with every unguessed letter replaced by an underscore.
    pub fn maskedWord(self: *const Game) []const u8 {
        return self.masked;
    }
};
