pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield
        .iter()
        .enumerate()
        .map(|(r_i, r)| {
            r.chars()
                .enumerate()
                .map(|(c_i, c)| match c {
                    ' ' => {
                        let mines = count_mines((r_i as i8, c_i as i8), minefield);

                        if mines == 0 {
                            return ' ';
                        }

                        char::from_digit(mines as u32, 10).unwrap()
                    }
                    _ => '*',
                })
                .collect()
        })
        .collect()
}

const DIRS: [(i8, i8); 8] = [
    (0, 1),
    (0, -1),
    (1, 0),
    (1, 1),
    (1, -1),
    (-1, 0),
    (-1, 1),
    (-1, -1),
];

fn count_mines((r_i, c_i): (i8, i8), minefield: &[&str]) -> usize {
    DIRS.iter()
        .filter_map(|(d_r, d_c)| in_bounds((r_i + d_r, c_i + d_c), minefield))
        .map(|(nr_i, nc_i)| {
            minefield[nr_i as usize]
                .chars()
                .nth(nc_i as usize)
                .unwrap_or(' ')
        })
        .filter(|f| *f == '*')
        .count()
}

fn in_bounds((r_i, c_i): (i8, i8), minefield: &[&str]) -> Option<(i8, i8)> {
    if minefield.is_empty() {
        return None;
    }

    let rows = minefield.len() as i8;
    let cols = minefield[0].len() as i8;

    if r_i < 0 || r_i > rows - 1 || c_i < 0 || c_i > cols - 1 {
        return None;
    }

    Some((r_i, c_i))
}
