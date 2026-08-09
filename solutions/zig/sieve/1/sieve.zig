const std = @import("std");

pub fn primes(buffer: []u32, comptime limit: usize) []u32 {
    if (limit < 2) return buffer[0..0];

    var marked = [_]bool{true} ** (limit + 1);
    marked[0] = false;
    marked[1] = false;

    for (2..limit) |i| {
        if (marked[i]) {
            var j: usize = i * i;
            while (j < limit + 1) : (j += i) {
                marked[j] = false;
            }
        }
    }

    var index: usize = 0;
    for (marked, 0..) |is_prime, i| {
        if (is_prime) {
            if (index >= buffer.len) break;

            buffer[index] = @as(u32, @intCast(i));
            index += 1;
        }
    }

    return buffer[0..index];
}
