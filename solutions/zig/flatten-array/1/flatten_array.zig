const std = @import("std");
const mem = std.mem;

pub const Box = union(enum) {
    none,
    one: i12,
    many: []const Box,
};

pub fn flatten(allocator: mem.Allocator, box: Box) mem.Allocator.Error![]i12 {
    var result: std.ArrayList(i12) = .empty;

    errdefer result.deinit(allocator);

    try unbox(allocator, &result, box);

    return result.toOwnedSlice(allocator);
}

fn unbox(allocator: mem.Allocator, result: *std.ArrayList(i12), box: Box) !void {
    switch (box) {
        .none => return,
        .one => |value| try result.append(allocator, value),
        .many => |boxes| for (boxes) |b|
            try unbox(allocator, result, b),
    }
}
