pub fn main() {
    println!("{:?}", spiral_matrix(4));
}

pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    if size == 0 {
        return vec![];
    }

    let mut matrix = vec![vec![0; size as usize]; size as usize];

    let mut r = 0usize;
    let mut r1 = size as usize;

    let mut c = 0usize;
    let mut c1 = size as usize;

    let mut v = 1;

    while v <= size * size {
        // right
        for n in c..c1 {
            matrix[r][n] = v;
            v += 1;
        }

        // down
        for n in r + 1..r1 {
            matrix[n][c1 - 1] = v;
            v += 1;
        }

        // left
        for n in (c..c1 - 1).rev() {
            matrix[r1 - 1][n] = v;
            v += 1;
        }

        // up
        for n in (r + 1..r1 - 1).rev() {
            matrix[n][c] = v;
            v += 1;
        }

        // update bounds
        r += 1;
        r1 -= 1;
        c += 1;
        c1 -= 1;
    }

    matrix
}
