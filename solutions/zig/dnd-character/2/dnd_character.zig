const std = @import("std");

pub fn main() !void {
    const c = Character.init();
    std.debug.print("c {}", .{c});
}

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    var t: std.Io.Threaded = .init_single_threaded;
    const io = t.io();
    const now = @as(u64, @intCast(std.Io.Timestamp.now(io, .real).toNanoseconds()));

    var prng = std.Random.DefaultPrng.init(now);
    const rand = prng.random();

    var rolls: [4]i8 = undefined;
    var sum: i8 = 0;
    var lowest: i8 = 6;

    for (&rolls) |*roll| {
        roll.* = rand.intRangeAtMost(i8, 1, 6);

        sum += roll.*;
        if (roll.* < lowest) {
            lowest = roll.*;
        }
    }

    return sum - lowest;
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();
        return .{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
        };
    }
};
