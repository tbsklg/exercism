const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, xs: []const u8) !bool {
    var stack: std.ArrayList(usize) = .empty;
    defer stack.deinit(allocator);

    for (xs) |s| {
        switch (s) {
            '[' => try stack.append(allocator, ']'),
            '(' => try stack.append(allocator, ')'),
            '{' => try stack.append(allocator, '}'),
            ']', ')', '}' => if (stack.popOrNull() != s) return false,
            else => {},
        }
    }

    return stack.items.len == 0;
}
