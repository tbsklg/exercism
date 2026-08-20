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
    var len: usize = 0;

    for (start_verse..end_verse + 1) |i| {
        const verse = try std.fmt.bufPrint(buffer[len..], "On the {s} day of Christmas my true love gave to me: ", .{numbers[i - 1]});
        len += verse.len;

        for (0..i) |j| {
            if (j != 0) {
                const comma = try std.fmt.bufPrint(buffer[len..], ", ", .{});
                len += comma.len;
            }

            if (j == i - 1 and j != 0) {
                const last = try std.fmt.bufPrint(buffer[len..], "and ", .{});
                len += last.len;
            }

            const present = try std.fmt.bufPrint(buffer[len..], "{s}", .{presents[i - 1 - j]});
            len += present.len;
        }

        const end = try std.fmt.bufPrint(buffer[len..], ".", .{});
        len += end.len;

        if (i != end_verse) {
            const new_line = try std.fmt.bufPrint(buffer[len..], "\n", .{});
            len += new_line.len;
        }
    }

    return buffer[0..len];
}
