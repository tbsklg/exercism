const std = @import("std");
const mem = std.mem;

pub fn slices(comptime slice_length: usize, allocator: mem.Allocator, series: []const u8) mem.Allocator.Error![][slice_length]u8 {
    comptime {
        std.debug.assert(slice_length > 0);
    }

    var result: std.ArrayList([slice_length]u8) = .empty;

    var i: usize = 0;

    while (i + slice_length <= series.len) : (i += 1) {

        const chunk: []const u8 = series[i .. i + slice_length];
        const array: [slice_length]u8 = chunk[0..slice_length].*;

        try result.append(allocator, array);
    }

    return result.toOwnedSlice(allocator);
}
