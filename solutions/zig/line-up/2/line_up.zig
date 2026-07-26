const std = @import("std");
const mem = std.mem;

pub fn main(init: std.process.Init) !void {
    const f = try format(init.gpa, "Pete", 11);
    defer init.gpa.free(f);
    std.debug.print("{s}", .{f});
}

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const ending: []const u8 = switch (number % 100) {
        11, 12, 13 => "th",
        else => switch (number % 10) {
            1 => "st",
            2 => "nd",
            3 => "rd",
            else => "th",
        },
    };

    return std.fmt.allocPrint(allocator, "{s}, you are the {d}{s} customer we serve today. Thank you!", .{ name, number, ending });
}
