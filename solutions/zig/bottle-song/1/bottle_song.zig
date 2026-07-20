const std = @import("std");

const numbers: [10][]const u8 = .{
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
};

const remainingNumbers: [10][]const u8 = .{
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
};

fn makeVerse(buffer: []u8, start_bottles: u32) ![]const u8 {
    const remaining = if (start_bottles == 0) 0 else start_bottles - 1;

    return try std.fmt.bufPrint(buffer,
        \\{s} green bottle{s} hanging on the wall,
        \\{s} green bottle{s} hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be {s} green bottle{s} hanging on the wall.
    , .{
        numbers[start_bottles - 1],
        if (start_bottles == 1) "" else "s",
        numbers[start_bottles - 1],
        if (start_bottles == 1) "" else "s",
        if (remaining == 0) "no" else remainingNumbers[remaining - 1],
        if (remaining == 1) "" else "s",
    });
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    var len: usize = 0;

    for (0..take_down) |i| {
        if (i != 0) {
            const new_line = try std.fmt.bufPrint(buffer[len..], "\n\n", .{});
            len += new_line.len;
        }

        const buff = try makeVerse(buffer[len..], start_bottles - @as(u32, @intCast(i)));
        len += buff.len;
    }

    return buffer[0..len];
}
