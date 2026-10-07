const std = @import("std");

pub const Category = enum(u8) {
    ones,
    twos,
    threes,
    fours,
    fives,
    sixes,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    var sorted = dice;
    std.mem.sort(u3, &sorted, {}, comptime std.sort.asc(u3));

    switch (category) {
        .full_house => {
            const fst = same(sorted[0..3]) and same(sorted[3..]);
            const snd = same(sorted[0..2]) and same(sorted[2..]);

            if (fst ^ snd) return sum(sorted[0..]);
        },
        .four_of_a_kind => {
            const fst = sorted[0..4];
            if (same(fst)) return sum(fst);

            const snd = sorted[1..];
            if (same(snd)) return sum(snd);
        },
        .little_straight => return little_straight(sorted[0..]) orelse 0,
        .big_straight => return big_straight(sorted[0..]) orelse 0,
        .choice => return sum(sorted[0..]),
        .yacht => if (same(sorted[0..])) return 50,
        .ones, .twos, .threes, .fours, .fives, .sixes => {
            const value: u3 = @intCast(@backingInt(category) + 1);
            var result: u32 = 0;
            for (dice) |d| {
                if (d == value) result += d;
            }
            return result;
        },
    }

    return 0;
}

fn little_straight(xs: []u3) ?u32 {
    var start: u32 = 0;
    for (xs) |x| {
        if (x != start + 1) return null;
        start = x;
    }
    return 30;
}

fn big_straight(xs: []u3) ?u32 {
    var start: u32 = 1;
    for (xs) |x| {
        if (x != start + 1) return null;
        start = x;
    }
    return 30;
}

fn same(xs: []u3) bool {
    if (xs.len == 0) return true;
    for (xs[1..]) |x| if (xs[0] != x) return false;
    return true;
}

fn sum(xs: []u3) u32 {
    var result: u32 = 0;
    for (xs) |x| result += x;
    return result;
}
