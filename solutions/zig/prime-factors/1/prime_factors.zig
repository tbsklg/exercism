const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var result: std.ArrayList(u64) = .empty;

    var current: u64 = value;
    var divisor: u64 = 2;

    while (divisor * divisor <= current) {
        if (current % divisor == 0) {
            try result.append(allocator, divisor);
            current /= divisor;
        } else {
            divisor += 1;
        }
    }

    if (current > 1) try result.append(allocator, current);

    return result.toOwnedSlice(allocator);
}
