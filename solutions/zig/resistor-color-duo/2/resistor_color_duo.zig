const std = @import("std");

pub const ColorBand = enum(u8) {
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
    return @intFromEnum(colors[0]) * 10 + @intFromEnum(colors[1]);
}
