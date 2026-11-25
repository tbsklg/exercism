const std = @import("std");
const mem = std.mem;

pub fn spiral(allocator: std.mem.Allocator, size: usize) ![][]u16 {
    const out = try allocator.alloc([]u16, size);
    var allocated: usize = 0;
    errdefer {
        for (out[0..allocated]) |row| allocator.free(row);
        allocator.free(out);
    }

    for (out) |*row| {
        row.* = try allocator.alloc(u16, size);
        allocated += 1;
    }

    var top: usize = 0;
    var bottom: usize = size;
    var left: usize = 0;
    var right: usize = size;
    var num: u16 = 1;

    while (top < bottom and left < right) {
        // Move right
        for (left..right) |c| {
            out[top][c] = num;
            num += 1;
        }
        top += 1;

        // Move down
        for (top..bottom) |r| {
            out[r][right - 1] = num;
            num += 1;
        }
        right -= 1;

        // Move left
        if (top < bottom) {
            var c = right;
            while (c > left) {
                c -= 1;
                out[bottom - 1][c] = num;
                num += 1;
            }
            bottom -= 1;
        }

        // Move up
        if (left < right) {
            var r = bottom;
            while (r > top) {
                r -= 1;
                out[r][left] = num;
                num += 1;
            }
            left += 1;
        }
    }

    return out;
}
