const std = @import("std");
const mem = std.mem;

/// Returns the selected row of the matrix.
pub fn row(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    var result: std.ArrayList(i16) = .empty;

    var iter = mem.splitScalar(u8, s, '\n');
    var rowNumber: usize = 1;

    while (iter.next()) |rs| {
        var rowIter = mem.splitScalar(u8, rs, ' ');

        while (rowIter.next()) |r| {
            const number = try std.fmt.parseInt(i16, r, 10);

            if (rowNumber == index) {
                try result.append(allocator, number);
            }
        }

        rowNumber += 1;
    }

    return result.toOwnedSlice(allocator);
}

/// Returns the selected column of the matrix.
pub fn column(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    var result: std.ArrayList(i16) = .empty;

    var iter = mem.splitScalar(u8, s, '\n');

    while (iter.next()) |rs| {
        var rowIter = mem.splitScalar(u8, rs, ' ');

        var colNumber: usize = 1;
        while (rowIter.next()) |r| {
            if (colNumber == index) {
                const number = try std.fmt.parseInt(i16, r, 10);
                try result.append(allocator, number);
            }
            colNumber += 1;
        }
    }

    return result.toOwnedSlice(allocator);
}
