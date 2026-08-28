const std = @import("std");
const mem = std.mem;

/// Encodes `plaintext` using the square code. Caller owns the returned memory.
pub fn ciphertext(allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
    var normalized: std.ArrayList(u8) = .empty;
    defer normalized.deinit(allocator);

    for (plaintext) |c| {
        if (std.ascii.isAlphanumeric(c)) {
            try normalized.append(allocator, std.ascii.toLower(c));
        }
    }

    if (normalized.items.len == 0) return "";

    const dim = dimension(normalized.items);
    const rows = dim.rows;
    const cols = dim.cols;

    const new_size = rows * cols + (cols - 1);
    var transformed = try allocator.alloc(u8, new_size);
    @memset(transformed, ' ');

    for (normalized.items, 0..) |n, i| {
        const col = i % cols;
        const row = i / cols;
        
        // rows + 1 => row + ' '
        const idx = col * (rows + 1) + row;
        transformed[idx] = n;
    }

    return transformed;
}

fn dimension(input: []const u8) struct { cols: usize, rows: usize } {
    const r = @sqrt(@as(f32, @floatFromInt(input.len)));
    var rows = @as(usize, @ceil(r));
    const cols = @as(usize, @ceil(r));

    if ((rows - 1) * cols >= input.len) rows -= 1;

    return .{ .rows = rows, .cols = cols };
}

test "9 chars result in 3 times 3" {
    const input = "tsfhiuisn";
    const result = dimension(input);

    try std.testing.expectEqual(3, result.cols);
    try std.testing.expectEqual(3, result.rows);
}

test "8 chars result in 3 times 3" {
    const input = "cluhltio";
    const result = dimension(input);

    try std.testing.expectEqual(3, result.cols);
    try std.testing.expectEqual(3, result.rows);
}

test "54 chars result in 8 times 7" {
    const input = "imtgdvsfearwermayoogoanouuiontnnlvtwttddesaohghnsseoau";
    const result = dimension(input);

    try std.testing.expectEqual(8, result.cols);
    try std.testing.expectEqual(7, result.rows);
}
