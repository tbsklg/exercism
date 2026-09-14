const std = @import("std");

pub fn isValid(xs: []const u8) bool {
    var sum: usize = 0;
    var pos: usize = 0;

    var iter = ReverseIterator.init(xs);

    while (iter.next()) |x| {
        if (std.ascii.isWhitespace(x)) continue;

        const maybeDigit = std.fmt.charToDigit(x, 10) catch return false;

        if (pos % 2 == 0) {
            sum += maybeDigit;
            pos += 1;
            continue;
        }

        const double = maybeDigit * 2;
        sum += if (double > 9) double - 9 else double;
        pos += 1;
    }

    if (pos <= 1) return false;

    return sum % 10 == 0;
}

const ReverseIterator = struct {
    buffer: []const u8,
    index: usize = 0,

    fn init(buffer: []const u8) ReverseIterator {
        return .{
            .buffer = buffer,
            .index = buffer.len,
        };
    }

    fn next(self: *ReverseIterator) ?u8 {
        if (self.index == 0) return null;

        self.index -= 1;

        return self.buffer[self.index];
    }
};

test "should return null for empty buffer" {
    var iter = ReverseIterator.init("");
    try std.testing.expectEqual(null, iter.next());
}

test "should return one elem" {
    var iter = ReverseIterator.init("1");
    try std.testing.expectEqual('1', iter.next());
}

test "should return elems from right to left" {
    var iter = ReverseIterator.init("055b 444 285");

    try std.testing.expectEqual('5', iter.next());
    try std.testing.expectEqual('8', iter.next());
    try std.testing.expectEqual('2', iter.next());
    try std.testing.expectEqual(' ', iter.next());
    try std.testing.expectEqual('4', iter.next());
    try std.testing.expectEqual('4', iter.next());
    try std.testing.expectEqual('4', iter.next());
}
