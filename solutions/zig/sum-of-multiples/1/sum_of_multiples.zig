const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var nums = std.AutoHashMap(u32, void).init(allocator);
    defer nums.deinit();

    var s: u64 = 0;
    for (factors) |f| {
        if (f == 0) continue;

        var i = f;
        while (i < limit) : (i += f) {
            if (i % f == 0 and !nums.contains(i)) {
                try nums.put(i, {});
                s += i;
            }
        }
    }

    return s;
}
