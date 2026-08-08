const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var signals: std.ArrayList(Signal) = .empty;
    errdefer {
        signals.deinit(allocator);
    }

    var pos: u5 = 0;
    var reverse = false;

    while (pos < 5) : (pos += 1) {
        const check = (number & (@as(u32, 1) << pos)) != 0;

        if (check) {
            if (pos == 0) try signals.append(allocator, .wink);
            if (pos == 1) try signals.append(allocator, .double_blink);
            if (pos == 2) try signals.append(allocator, .close_your_eyes);
            if (pos == 3) try signals.append(allocator, .jump);
            if (pos == 4) reverse = true;
        }
    }

    if (reverse) mem.reverse(Signal, signals.items);
    return signals.toOwnedSlice(allocator);
}
