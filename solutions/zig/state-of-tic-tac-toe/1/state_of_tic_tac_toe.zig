pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

pub fn gameState(board: []const []const u8) GameState {
    const a = board[0][0];
    const b = board[0][1];
    const c = board[0][2];
    const d = board[1][0];
    const e = board[1][1];
    const f = board[1][2];
    const g = board[2][0];
    const h = board[2][1];
    const i = board[2][2];

    const x_win =
        (a == 'X' and a == b and b == c) or
        (d == 'X' and d == e and e == f) or
        (g == 'X' and g == h and h == i) or
        (a == 'X' and a == d and d == g) or
        (b == 'X' and b == e and e == h) or
        (c == 'X' and c == f and f == i) or
        (a == 'X' and a == e and e == i) or
        (g == 'X' and g == e and e == c);

    const o_win =
        (a == 'O' and a == b and b == c) or
        (d == 'O' and d == e and e == f) or
        (g == 'O' and g == h and h == i) or
        (a == 'O' and a == d and d == g) or
        (b == 'O' and b == e and e == h) or
        (c == 'O' and c == f and f == i) or
        (a == 'O' and a == e and e == i) or
        (g == 'O' and g == e and e == c);

    var x_count: usize = 0;
    var o_count: usize = 0;
    var has_empty = false;

    for (board) |row| {
        for (row) |cell| {
            if (cell == 'X') x_count += 1;
            if (cell == 'O') o_count += 1;
            if (cell == ' ') has_empty = true;
        }
    }

    if (o_count > x_count or x_count > o_count + 1) {
        return .impossible;
    }

    if (x_win and o_win) {
        return .impossible;
    }

    if (x_win and x_count != o_count + 1) {
        return .impossible;
    }

    if (o_win and x_count != o_count) {
        return .impossible;
    }

    if (x_win or o_win) {
        return .win;
    }

    if (has_empty) {
        return .ongoing;
    }

    return .draw;
}
