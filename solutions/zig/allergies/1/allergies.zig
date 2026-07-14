const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    const target = @intFromEnum(allergen);
    return binary(score)[target] == 1;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var set = std.EnumSet(Allergen).init(.{});
    const bin = binary(score);
    const fields = @typeInfo(Allergen).@"enum".fields;

    inline for (fields, 0..) |field, i| {
        if (bin[i] == 1) {
            const allergen_value = @field(Allergen, field.name);
            set.insert(allergen_value);
        }
    }

    return set;
}

fn binary(num: usize) [16]usize {
    var result: [16]usize = undefined;
    var curr = num;
    var i: u8 = 0;

    while (curr != 0) : (curr /= 2) {
        result[i] = curr % 2;
        i += 1;
    }

    return result;
}
