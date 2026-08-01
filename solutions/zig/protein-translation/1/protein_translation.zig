const std = @import("std");

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
};

fn pack(comptime s: *const [3:0]u8) u24 {
    return @as(u24, s[0]) << 16 | @as(u24, s[1]) << 8 | s[2];
}

fn mapProtein(p: []const u8) TranslationError!?Protein {
    const key = @as(u24, p[0]) << 16 | @as(u24, p[1]) << 8 | p[2];
    return switch (key) {
        pack("AUG") => .methionine,
        pack("UUU"), pack("UUC") => .phenylalanine,
        pack("UUA"), pack("UUG") => .leucine,
        pack("UCU"), pack("UCC"), pack("UCA"), pack("UCG") => .serine,
        pack("UAU"), pack("UAC") => .tyrosine,
        pack("UGU"), pack("UGC") => .cysteine,
        pack("UGG") => .tryptophan,
        pack("UAA"), pack("UAG"), pack("UGA") => null,
        else => TranslationError.InvalidCodon,
    };
}

pub fn proteins(allocator: std.mem.Allocator, strand: []const u8) (std.mem.Allocator.Error || TranslationError)![]Protein {
    var ps: std.ArrayList(Protein) = .empty;
    defer ps.deinit(allocator);

    var i: usize = 0;

    while (i < strand.len) : (i += 3) {
        if (i + 3 > strand.len) return TranslationError.InvalidCodon;

        if (try mapProtein(strand[i .. i + 3])) |protein| {
            try ps.append(allocator, protein);
        } else break;
    }

    return ps.toOwnedSlice(allocator);
}
