const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;

    var result: std.ArrayList(u32) = .empty;

    var current: u32 = try base10(digits, input_base);
    if (current == 0) try result.append(allocator, 0);

    while (current != 0) {
        try result.append(allocator, current % output_base);
        current /= output_base;
    }

    std.mem.reverse(u32, result.items);

    return result.toOwnedSlice(allocator);
}

fn base10(digits: []const u32, base: u32) ConversionError!u32 {
    var output: u32 = 0;

    for (0..digits.len) |i| {
        const digit = digits[digits.len - i - 1];
        if (digit >= base) return ConversionError.InvalidDigit;
        output += std.math.pow(u32, base, @as(u32, @intCast(i))) * digit;
    }

    return output;
}
