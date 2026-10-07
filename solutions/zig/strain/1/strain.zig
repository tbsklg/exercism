const std = @import("std");
const mem = std.mem;

/// Returns the items of `list` for which `predicate` is true, in order.
/// Caller owns the returned memory.
pub fn keep(
    comptime T: type,
    allocator: mem.Allocator,
    list: []const T,
    comptime predicate: fn (T) bool,
) mem.Allocator.Error![]T {
    var result: std.ArrayList(T) = .empty;

    for (list) |l| {
        if (predicate(l)) try result.append(allocator, l);
    }

    return result.toOwnedSlice(allocator);
}

/// Returns the items of `list` for which `predicate` is false, in order.
/// Caller owns the returned memory.
pub fn discard(
    comptime T: type,
    allocator: mem.Allocator,
    list: []const T,
    comptime predicate: fn (T) bool,
) mem.Allocator.Error![]T {
    var result: std.ArrayList(T) = .empty;

    for (list) |l| {
        if (!predicate(l)) try result.append(allocator, l);
    }

    return result.toOwnedSlice(allocator);
}
