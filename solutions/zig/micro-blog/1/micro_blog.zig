const std = @import("std");

pub fn truncate(phrase: []const u8) []const u8 {
    var iter = std.unicode.Utf8View.initUnchecked(phrase).iterator();
    return iter.peek(5);
}
