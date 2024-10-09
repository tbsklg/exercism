pub fn main() {
    println!("{:?}", spiral_matrix(4));
}

pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    if size == 0 {
        return vec![];
    }

    let mut matrix = vec![vec![0; size as usize]; size as usize];

    let mut r = 0usize;
    let mut c = 0usize;
    let mut n = 1u32;

    while n <= size * size {
        while c < (size - 1) as usize && matrix[r][c] == 0 {
            matrix[r][c] = n;
            n += 1;
            c += 1;
        }

        while r < (size - 1) as usize && matrix[r][c] == 0 {
            matrix[r][c] = n;
            n += 1;
            r += 1;
        }
        while c < (size - 1) as usize && matrix[r][c] == 0 {
            matrix[r][c] = n;
            n += 1;
            c -= 1;
        }
        while r < (size - 1) as usize && matrix[r][c] == 0 {
            matrix[r][c] = n;
            n += 1;
            r -= 1;
        }
    }

    matrix
}
