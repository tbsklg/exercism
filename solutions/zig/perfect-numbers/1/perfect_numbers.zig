const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    var sum: usize = 0;
    var curr: usize = 1;

    while (curr < n) : (curr += 1) {
        if (curr == n) break;
        if (n % curr == 0) sum += curr;
    }
    
    if (sum > n) return Classification.abundant;
    if (sum == n) return Classification.perfect;

    return Classification.deficient;
}
