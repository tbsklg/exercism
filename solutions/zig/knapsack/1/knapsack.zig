const std = @import("std");
const mem = std.mem;

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;

    const items: [5]Item = .{
        Item.init(2, 5),
        Item.init(2, 5),
        Item.init(2, 5),
        Item.init(2, 5),
        Item.init(10, 21),
    };

    const v = try maximumValue(gpa, 10, &items);
    std.debug.print("{d}", .{v});
}

pub const Item = struct {
    weight: usize,
    value: usize,

    pub fn init(weight: usize, value: usize) Item {
        return .{
            .weight = weight,
            .value = value,
        };
    }
};

fn lessThanWeight(context: void, a: Item, b: Item) bool {
    _ = context;
    return a.weight < b.weight;
}

pub fn maximumValue(allocator: mem.Allocator, maximumWeight: usize, items: []const Item) !usize {
    const sortedItemsByWeight = try allocator.dupe(Item, items);
    defer allocator.free(sortedItemsByWeight);

    std.mem.sort(Item, sortedItemsByWeight, {}, lessThanWeight);  

    return max(maximumWeight, sortedItemsByWeight, 0, 0);
}

fn max(maximumWeight: usize, items: []const Item, currentWeight: usize, currentValue: usize) usize {
    if (items.len == 0) return currentValue;

    const head = items[0];
    const tail = items[1..];

    if (head.weight + currentWeight > maximumWeight) {
        return currentValue;
    }

    const valueWith = max(
        maximumWeight, 
        tail, 
        currentWeight + head.weight, 
        currentValue + head.value
    );

    const valueWithout = max(
        maximumWeight, 
        tail, 
        currentWeight, 
        currentValue
    );

    return @max(valueWith, valueWithout);
}
