const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var map = std.AutoHashMap(u8, i5).init(allocator);
    var iter = legacy.iterator();

    while (iter.next()) |kv| {
        const p = kv.key_ptr.*;
        const ks = kv.value_ptr.*;

        for (ks) |k| {
            try map.put(std.ascii.toLower(k), p);
        }
    }

    return map;
}
