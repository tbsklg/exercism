const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, letter: u8) mem.Allocator.Error![][]u8 {
    std.debug.assert(letter >= 'A');
    std.debug.assert(letter <= 'Z');

    const n = 2 * (letter - 'A') + 1;

    const diamond = try allocator.alloc([]u8, n);
    @memset(diamond, &.{});

    errdefer {
        for (diamond) |row| if (row.len > 0) allocator.free(row);
        allocator.free(diamond);
    }

    for (0..n / 2 + 1) |i| {
        diamond[i] = try buildRow(allocator, n, i);
        if (i != n / 2) diamond[n - 1 - i] = try buildRow(allocator, n, i);
    }

    return diamond;
}

fn buildRow(allocator: mem.Allocator, n: u8, i: usize) ![]u8 {
    const row = try allocator.alloc(u8, n);
    @memset(row, ' ');

    const letter = @as(u8, @intCast('A' + i));
    const left = n / 2 - i;
    row[left] = letter;

    const right = n / 2 + i;
    row[right] = letter;

    return row;
}
