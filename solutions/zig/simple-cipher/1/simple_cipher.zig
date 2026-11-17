const std = @import("std");
const mem = std.mem;

pub const Cipher = struct {
    key: []const u8,

    /// Initializes a cipher with a copy of the given key.
    pub fn init(allocator: mem.Allocator, key: []const u8) mem.Allocator.Error!Cipher {
        return .{
            .key = try allocator.dupe(u8, key),
        };
    }

    /// Initializes a cipher with a randomly generated key of at least 100
    /// lowercase letters.
    pub fn initRandom(allocator: mem.Allocator, random: std.Random) mem.Allocator.Error!Cipher {
        var random_key: [100]u8 = undefined;

        for (&random_key) |*char| {
            char.* = random.intRangeLessThan(u8, 'a', 'z' + 1);
        }

        return try Cipher.init(allocator, &random_key);
    }

    /// Frees the key.
    pub fn deinit(self: *Cipher, allocator: mem.Allocator) void {
        allocator.free(self.key);
    }

    /// Encodes `plaintext`. Caller owns the returned memory.
    pub fn encode(self: Cipher, allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
        var encoded = try allocator.alloc(u8, plaintext.len);

        for (plaintext, 0..) |t, i| {
            const key = self.key[i % self.key.len];
            const pos = key - 'a';

            encoded[i] = 'a' + ((t + pos - 'a') % 26);
        }

        return encoded;
    }

    /// Decodes `ciphertext`. Caller owns the returned memory.
    pub fn decode(self: Cipher, allocator: mem.Allocator, ciphertext: []const u8) mem.Allocator.Error![]u8 {
        var decoded = try allocator.alloc(u8, ciphertext.len);

        for (ciphertext, 0..) |t, i| {
            const key = self.key[i % self.key.len];
            const pos = key - 'a';

            decoded[i] = 'a' + (((t - 'a') + 26 - pos) % 26);
        }

        return decoded;
    }
};
