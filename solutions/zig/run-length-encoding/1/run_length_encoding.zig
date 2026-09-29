const std = @import("std");

pub fn encode(buffer: []u8, string: []const u8) []u8 {
    var iter = Iter.init(string);
    var writer = std.Io.Writer.fixed(buffer);

    var count: usize = 1;

    while (iter.next()) |s| {
        if (iter.peek() == s) {
            count += 1;
            continue;
        }

        if (count == 1) {
            _ = writer.writeByte(s) catch unreachable;
            continue;
        }

        _ = writer.print("{d}", .{count}) catch unreachable;
        _ = writer.writeByte(s) catch unreachable;
        count = 1;
    }

    return writer.buffered();
}

pub fn decode(buffer: []u8, string: []const u8) []u8 {
    var iter = Iter.init(string);
    var writer = std.Io.Writer.fixed(buffer);

    while (iter.next()) |c| {
        if (!std.ascii.isDigit(c)) {
            writer.writeByte(c) catch unreachable;
            continue;
        }

        var count: usize = c - '0';
        while (iter.peek()) |p| {
            if (!std.ascii.isDigit(p)) break;
            count = count * 10 + (iter.next().? - '0');
        }

        const repeated = iter.next().?;
        for (0..count) |_| {
            writer.writeByte(repeated) catch unreachable;
        }
    }

    return writer.buffered();
}

const Iter = struct {
    buffer: []const u8,
    index: usize,

    pub fn init(buffer: []const u8) Iter {
        return .{
            .buffer = buffer,
            .index = 0,
        };
    }

    pub fn next(self: *Iter) ?u8 {
        if (self.index >= self.buffer.len) return null;
        const current = self.buffer[self.index];
        self.index += 1;

        return current;
    }

    pub fn peek(self: *Iter) ?u8 {
        if (self.index >= self.buffer.len) return null;

        return self.buffer[self.index];
    }
};

test "should return null for empty buffer" {
    const xs = "";
    var iter = Iter.init(xs);

    try std.testing.expectEqual(null, iter.next());
}

test "should read next char" {
    const xs = "ab";
    var iter = Iter.init(xs);

    try std.testing.expectEqual('a', iter.next());
    try std.testing.expectEqual('b', iter.next());
}

test "should peek next char" {
    const xs = "ab";
    var iter = Iter.init(xs);

    try std.testing.expectEqual('a', iter.next());
    try std.testing.expectEqual('b', iter.peek());

    try std.testing.expectEqual('b', iter.next());
    try std.testing.expectEqual(null, iter.peek());
}
