const std = @import("std");

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

fn isSublist(needle: []const i32, haystack: []const i32) bool {
    return needle.len == 0 or std.mem.find(i32, haystack, needle) != null;
}

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (std.mem.eql(i32, list_one, list_two)) return Relation.equal;
    if (isSublist(list_one, list_two)) return Relation.sublist;
    if (isSublist(list_two, list_one)) return Relation.superlist;
    return Relation.unequal;
}
