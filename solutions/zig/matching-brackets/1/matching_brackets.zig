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
            else => {
                if (s == ']' or s == ')' or s == '}') {
                    const expected = stack.pop() orelse return false;
                    if (expected != s) return false;
                }
            },
        }
    }

    if (stack.items.len > 0) return false;

    return true;
}
