const std = @import("std");

pub fn toRoman(allocator: std.mem.Allocator, i: i16) ![]u8 {
    var out = std.Io.Writer.Allocating.init(allocator);
    defer out.deinit();

    try as_numeral(&out.writer, @as(usize, @intCast(i)));

    return out.toOwnedSlice();
}


fn as_numeral(writer: *std.Io.Writer, i: usize) !void {
    if (i == 0) return;
    
    if (i >= 1000) {
        _ = try writer.write("M");
        return try as_numeral(writer, i - 1000);
    }
    
    if (i >= 900) {
        _ = try writer.write("CM");
        return try as_numeral(writer, i - 900);
    }
    
    if (i >= 500) {
        _ = try writer.write("D");
        return try as_numeral(writer, i - 500);
    }
    
    if (i >= 400) {
        _ = try writer.write("CD");
        return try as_numeral(writer, i - 400);
    }

    if (i >= 100) {
        _ = try writer.write("C");
        return try as_numeral(writer, i - 100);
    }

    if (i >= 90) {
        _ = try writer.write("XC");
        return try as_numeral(writer, i - 90);
    }
    
    if (i >= 50) {
        _ = try writer.write("L");
        return try as_numeral(writer, i - 50);
    }
    
    if (i >= 40) {
        _ = try writer.write("XL");
        return try as_numeral(writer, i - 40);
    }
    
    if (i >= 10) {
        _ = try writer.write("X");
        return try as_numeral(writer, i - 10);
    }
    
    if (i >= 9) {
        _ = try writer.write("IX");
        return try as_numeral(writer, i - 9);
    }
    
    if (i >= 5) {
        _ = try writer.write("V");
        return try as_numeral(writer, i - 5);
    }
    
    if (i >= 4) {
        _ = try writer.write("IV");
        return try as_numeral(writer, i - 4);
    }
    
    if (i >= 1) {
        _ = try writer.write("I");
        return try as_numeral(writer, i - 1);
    }
}
