const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    var chunk: usize = 0;
    for (s) |c| {
        if (shift(c)) |shifted| {
            if (chunk == 5) {
                try result.append(allocator, ' ');
                chunk = 0;
            }

            try result.append(allocator, shifted);
            chunk += 1;
        }
    }

    return result.toOwnedSlice(allocator);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    for (s) |c| {
        if (shift(c)) |shifted| try result.append(allocator, shifted);
    }

    return result.toOwnedSlice(allocator);
}

fn shift(c: u8) ?u8 {
    if (std.ascii.isAlphabetic(c)) return 'a' + 'z' - std.ascii.toLower(c);
    if (std.ascii.isDigit(c)) return c;

    return null;
}
