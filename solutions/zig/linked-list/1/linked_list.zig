const std = @import("std");

pub fn main(_: std.process.Init) !void {
    const a: ?usize = 1;
    var x: usize = 0;

    const b = a orelse {
        x = 1;
        return;
    };

    std.debug.print("b {any}", .{b});
}

pub fn LinkedList(comptime T: type) type {
    return struct {
        // Please implement the doubly linked `Node` (replacing each `void`).
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T = 0,
        };

        // Please implement the fields of the linked list (replacing each `void`).
        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        // Please implement the below methods.
        // You need to add the parameters to each method.

        pub fn push(self: *LinkedList(T), node: *Node) void {
            const last = self.last orelse {
                self.first = node;
                self.last = node;
                self.len += 1;
                return;
            };

            last.next = node;
            node.prev = last;
            self.last = node;
            self.len += 1;
        }

        pub fn pop(self: *LinkedList(T)) ?*Node {
            const last = self.last;
            if (last == null) return null;

            self.last = last.?.prev;
            self.len -= 1;

            return last;
        }

        pub fn shift(self: *LinkedList(T)) ?*Node {
            const first = self.first orelse return null;
            const next = first.next orelse {
                self.first = null;
                self.last = null;
                self.len -= 1;
                return first;
            };

            self.first = next;
            self.first.?.prev = null;
            self.len -= 1;

            return first;
        }

        pub fn unshift(self: *LinkedList(T), node: *Node) void {
            const first = self.first orelse {
                self.first = node;
                self.last = node;
                self.len += 1;
                return;
            };

            self.first = node;
            self.first.?.next = first;
            first.prev = self.first;

            self.len += 1;
        }

        pub fn delete(self: *LinkedList(T), node: *Node) void {
            const prev = node.prev orelse {
                if (self.first == node) _ = self.shift();
                return;
            };

            const next = node.next orelse {
                if (self.last == node) _ = self.pop();
                return;
            };

            prev.next = next;
            next.prev = prev;

            self.len -= 1;
        }
    };
}
