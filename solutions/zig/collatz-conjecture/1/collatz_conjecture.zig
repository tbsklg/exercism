// Please implement the `ComputationError.IllegalArgument` error.
pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) ComputationError!usize {
    if (number == 0) return ComputationError.IllegalArgument;

    var curr: usize = number;
    var step: usize = 0;

    while (curr != 1) : (step += 1) {
        if (curr % 2 == 0) {
            curr /= 2;
        } else {
            curr = curr * 3 + 1;
        }
    }

    return step;
}
