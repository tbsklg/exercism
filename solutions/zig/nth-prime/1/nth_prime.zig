const std = @import("std");
const mem = std.mem;

pub fn prime(_: mem.Allocator, number: usize) !usize {
    if (number == 0) return error.InvalidNumber;

    var primes: Primes = .{};
    var next_prime: usize = 0;

    for (0..number) |_| {
        next_prime = primes.next();
    }

    return next_prime;
}

const Primes = struct {
    current: usize = 1,

    fn next(self: *Primes) usize {
        var maybe_prime = self.current + 1;

        while (true) : (maybe_prime += 1) {
            switch (checkIfPrime(maybe_prime)) {
                .prime => {
                    self.current = maybe_prime;
                    break;
                },
                .composite => {},
            }
        }

        return self.current;
    }
};

fn checkIfPrime(x: usize) enum { prime, composite } {
    std.debug.assert(x > 1);

    const limit = std.math.sqrt(x);

    for (2..limit + 1) |i| {
        if (x % i == 0) return .composite;
    }

    return .prime;
}
