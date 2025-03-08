pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield
        .iter()
        .enumerate()
        .map(|(row_idx, row)| {
            row.chars()
                .enumerate()
                .map(|(col_idx, cell)| match cell {
                    '*' => '*',
                    _ => {
                        let mines = count_adjacent_mines(row_idx, col_idx, minefield);
                        match mines {
                            0 => ' ',
                            n => char::from_digit(n as u32, 10).unwrap(),
                        }
                    }
                })
                .collect::<String>()
        })
        .collect()
}

fn count_adjacent_mines(row: usize, col: usize, minefield: &[&str]) -> usize {
    const DIRECTIONS: [(isize, isize); 8] = [
        (-1, -1),
        (-1, 0),
        (-1, 1),
        (0, -1),
        (0, 1),
        (1, -1),
        (1, 0),
        (1, 1),
    ];

    let row_count = minefield.len() as isize;
    let col_count = minefield.first().map_or(0, |r| r.len()) as isize;

    DIRECTIONS
        .iter()
        .filter_map(|(dr, dc)| {
            let new_row = row as isize + dr;
            let new_col = col as isize + dc;

            (new_row >= 0 && new_row < row_count && new_col >= 0 && new_col < col_count)
                .then_some((new_row as usize, new_col as usize))
        })
        .filter(|(r, c)| (minefield.get(*r).and_then(|row| row.chars().nth(*c))) == Some('*'))
        .count()
}
