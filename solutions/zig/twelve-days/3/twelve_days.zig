const std = @import("std");

const numbers: [12][]const u8 = .{
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
};

const presents: [12][]const u8 = .{
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    var w: std.Io.Writer = .fixed(buffer);

    for (start_verse..end_verse + 1) |i| {
        try w.print("On the {s} day of Christmas my true love gave to me: ", .{numbers[i - 1]});

        for (0..i) |j| {
            if (j != 0) {
                try w.print(", ", .{});
            }

            if (j == i - 1 and j != 0) {
                try w.print("and ", .{});
            }

            try w.print("{s}", .{presents[i - 1 - j]});
        }

        try w.print(".", .{});

        if (i != end_verse) {
            try w.print("\n", .{});
        }
    }

    return w.buffered();
}
