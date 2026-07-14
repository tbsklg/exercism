const std = @import("std");
const mem = std.mem;

pub const ColorBand = enum(u64) {
    black,
    brown,
    red,
    orange,
    yellow,
    green,
    blue,
    violet,
    grey,
    white,
};

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    const first = @intFromEnum(colors[0]);
    const snd = @intFromEnum(colors[1]);
    const exp = @intFromEnum(colors[2]);

    const value = (first * 10 + snd) * std.math.pow(u128, 10, exp);

    const prefixes = [_][]const u8{ "", "kilo", "mega", "giga" };

    var idx: usize = 0;
    var divisor: u128 = 1;
    while (idx < prefixes.len - 1 and value / divisor >= 1000) : (idx += 1) {
        divisor *= 1000;
    }

    const scaled = @as(f64, @floatFromInt(value)) / @as(f64, @floatFromInt(divisor));

    return try std.fmt.allocPrint(allocator, "{d} {s}ohms", .{ scaled, prefixes[idx] });
}
