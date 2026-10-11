const std = @import("std");

pub const Category = enum {
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
    var result: u32 = 0;

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
        .little_straight => if (littleStraight(sorted[0..])) return 30,
        .big_straight => if (bigStraight(sorted[0..])) return 30,
        .choice => return sum(sorted[0..]),
        .yacht => if (same(sorted[0..])) return 50,
        else => for (dice) |d| {
            if (category == .ones and d == 1) result += 1;
            if (category == .twos and d == 2) result += 2;
            if (category == .threes and d == 3) result += 3;
            if (category == .fours and d == 4) result += 4;
            if (category == .fives and d == 5) result += 5;
            if (category == .sixes and d == 6) result += 6;
        },
    }

    return result;
}

fn littleStraight(xs: []u3) bool {
    var start: u32 = 0;
    for (xs) |x| {
        if (x != start + 1) return false;
        start = x;
    }
    return true;
}

fn bigStraight(xs: []u3) bool {
    var start: u32 = 1;
    for (xs) |x| {
        if (x != start + 1) return false;
        start = x;
    }
    return true;
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
