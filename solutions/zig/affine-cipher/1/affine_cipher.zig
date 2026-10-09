const std = @import("std");
const mem = std.mem;

pub const AffineCipherError = error{
    NotCoprime,
};

pub fn main(_: std.process.Init) !void {
    const g = ggt(25, 47); 
    std.debug.print("ggt {d}", .{g});
}

/// Encodes `phrase` using the affine cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, phrase: []const u8, a: u8, b: u8) ![]u8 {
    if (ggt(a, 26) != 1) return AffineCipherError.NotCoprime;

    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    var chunk: usize = 0;
    for (phrase) |letter| {
        if (std.ascii.isWhitespace(letter)) continue;
        if (std.ascii.isPunctuation(letter)) continue;

        if (chunk == 5) {
            try result.append(allocator, ' ');
            chunk = 0;
        }

        const encrypted = encrypt(letter, a, b);

        try result.append(allocator, encrypted);
        chunk += 1;
    }

    return result.toOwnedSlice(allocator);
}

fn ggt(a: u8, b: u8) u8 {
    if (a == 0) return b;
    if (b == 0) return a;

    return ggt(b, a % b);
}

fn encrypt(letter: u8, a: u8, b: u8) u8 {
    if (std.ascii.isDigit(letter)) return letter;

    const i = @as(usize, std.ascii.toLower(letter) - 'a');
    return 'a' + @as(u8, @intCast((a * i + b) % 26));
}

fn getInverse(a: i32) i32 {
    var i: i32 = 1;
    while (i < 26) : (i += 1) {
        if (@rem(a * i, 26) == 1) {
            return i;
        }
    }
    unreachable;
}

pub fn decrypt(letter: u8, a: u8, b: u8) u8 {
    if (letter < 'a' or letter > 'z') return letter;

    const y: i32 = letter - 'a';
    const a_i32: i32 = a;
    const b_i32: i32 = b;

    const a_inv = getInverse(a_i32);
    
    const decrypted_y = @mod(a_inv * (y - b_i32), 26);
    return @as(u8, @intCast(decrypted_y)) + 'a';
}

/// Decodes `phrase` using the affine cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, phrase: []const u8, a: u8, b: u8) (mem.Allocator.Error || AffineCipherError)![]u8 {
    if (ggt(a, 26) != 1) return AffineCipherError.NotCoprime;

    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);
    
    for (phrase) |letter| {
        if (std.ascii.isWhitespace(letter)) continue;
        if (std.ascii.isPunctuation(letter)) continue;

        const decrypted = decrypt(letter, a, b);

        try result.append(allocator, decrypted);
    }

    return result.toOwnedSlice(allocator);
}
