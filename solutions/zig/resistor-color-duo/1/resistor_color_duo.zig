const std = @import("std");

pub const ColorBand = enum {
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

pub fn colorCode(colors: [2]ColorBand) usize {
    return @as(usize, @intFromEnum(colors[0])) * 10 + @intFromEnum(colors[1]);
}
