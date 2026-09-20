const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, count: usize) mem.Allocator.Error![][]u128 {
    const result = try allocator.alloc([]u128, count);
    var row_index: usize = 0;

    errdefer {
        for (0..row_index) |i| allocator.free(result[i]);
        allocator.free(result);
    }

    while (row_index < count) : (row_index += 1) {
        var row = try allocator.alloc(u128, row_index + 1);

        if (row_index == 0) {
            row[0] = 1;
            result[row_index] = row;
            continue;
        }

        const prev_row = result[row_index - 1];

        for (0..row_index + 1) |j| {
            const x = if (j == 0) 0 else prev_row[j - 1];
            const y = if (j > prev_row.len - 1) 0 else prev_row[j];
            row[j] = x + y;
        }

        result[row_index] = row;
    }

    return result;
}
