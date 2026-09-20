const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, count: usize) mem.Allocator.Error![][]u128 {
    const result = try allocator.alloc([]u128, count);
    var row_index: usize = 0;

    errdefer {
        for (0..row_index) |i| {
            allocator.free(result[i]);
        }
        allocator.free(result);
    }

    while (row_index < count) : (row_index += 1) {
        const row = try allocator.alloc(u128, row_index + 1);

        if (row_index == 0) {
            row[0] = 1;
        } else {
            const prev_row = result[row_index - 1];

            row[0] = 1;

            for (1..row_index) |j| {
                row[j] = prev_row[j - 1] + prev_row[j];
            }

            row[row_index] = 1;
        }

        result[row_index] = row;
    }

    return result;
}
