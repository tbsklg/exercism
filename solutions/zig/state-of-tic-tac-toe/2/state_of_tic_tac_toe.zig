pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

fn win(player: u8, board: []const []const u8) bool {
    const a = board[0][0];
    const b = board[0][1];
    const c = board[0][2];
    const d = board[1][0];
    const e = board[1][1];
    const f = board[1][2];
    const g = board[2][0];
    const h = board[2][1];
    const i = board[2][2];

    return (a == player and a == b and b == c) or
        (d == player and d == e and e == f) or
        (g == player and g == h and h == i) or
        (a == player and a == d and d == g) or
        (b == player and b == e and e == h) or
        (c == player and c == f and f == i) or
        (a == player and a == e and e == i) or
        (g == player and g == e and e == c);
}

pub fn gameState(board: []const []const u8) GameState {
    const x_win = win('X', board);
    const o_win = win('O', board);

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
