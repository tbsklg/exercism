const std = @import("std");

pub const Planet = enum {
    earth,
    mercury,
    venus,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const faktor: f64 = switch (self) {
            .earth => 1.0,
            .mercury => 0.2408467,
            .venus => 0.61519726,
            .mars => 1.8808158,
            .jupiter => 11.862615,
            .saturn => 29.447498,
            .uranus => 84.016846,
            .neptune => 164.79132,
        };

        return @as(f64, @floatFromInt(seconds)) / (31_557_600 * faktor);
    }
};
