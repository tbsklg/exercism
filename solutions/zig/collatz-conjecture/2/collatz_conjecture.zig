pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) ComputationError!usize {
    if (number == 0) return ComputationError.IllegalArgument;
    return go(number, 0);
}

fn go(curr: usize, step: usize) usize {
    if (curr == 1) return step;
    const next = if (curr % 2 == 0) curr / 2 else curr * 3 + 1;
    return @call(.always_tail, go, .{ next, step + 1 });
}
