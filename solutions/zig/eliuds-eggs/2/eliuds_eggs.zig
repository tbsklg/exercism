pub fn eggCount(number: usize) usize {
    var eggs: usize = 0;
    var curr = number;

    while (curr != 0) : (curr >>= 1) {
        eggs += curr & 1;
    }

    return eggs;
}
