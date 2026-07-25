const std = @import("std");

pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,

    pub fn parse(c: u8) Plant {
        return switch (c) {
            'R' => .radishes,
            'C' => .clover,
            'V' => .violets,
            'G' => .grass,
            else => unreachable,
        };
    }
};

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const students: [12][]const u8 = .{
        "Alice",
        "Bob",
        "Charlie",
        "David",
        "Eve",
        "Fred",
        "Ginny",
        "Harriet",
        "Ileana",
        "Joseph",
        "Kincaid",
        "Larry",
    };
    const position = findStringInArray(&students, student).?;

    var lines = std.mem.splitScalar(u8, diagram, '\n');
    const first = lines.next().?;
    const second = lines.next().?;

    var result: [4]Plant = undefined;

    result[0] = Plant.parse(first[position * 2]);
    result[1] = Plant.parse(first[position * 2 + 1]);
    result[2] = Plant.parse(second[position * 2]);
    result[3] = Plant.parse(second[position * 2 + 1]);

    return result;
}

fn findStringInArray(haystack: []const []const u8, needle: []const u8) ?usize {
    for (haystack, 0..) |item, index| {
        if (std.mem.eql(u8, item, needle)) return index;
    }
    return null;
}
