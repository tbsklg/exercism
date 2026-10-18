const std = @import("std");

pub fn combinations(buffer: []u9, sum: usize, cage: usize, exclude: u9) []const u9 {
    var idx: usize = 0;

    for (1..512) |i| {
        const mask: u9 = @intCast(i);
        if (@popCount(mask) != cage) continue;

        if ((mask & exclude) != 0) continue;

        if (calcSum(mask) == sum) {
            buffer[idx] = mask;
            idx += 1;
        }
    }

    return buffer[0..idx];
}

fn calcSum(x: u9) usize {
    var sum: u9 = 0;

    for (0..9) |i| {
        if ((@as(u9, 1) << @as(u4, @intCast(i)) & x) > 0)
            sum += @as(u9, @intCast(i)) + 1;
    }

    return sum;
}
