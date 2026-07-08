pub fn eggCount(number: usize) usize {
    var eggs: usize = 0;
    var curr = number;

    while (curr != 0) : (curr /= 2) {
        if (curr % 2 == 1) eggs += 1;
    }

    return eggs;
}
