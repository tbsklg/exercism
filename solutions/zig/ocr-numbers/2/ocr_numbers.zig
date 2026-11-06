const std = @import("std");

pub const RecognitionError = error{
    InvalidRowCount,
    InvalidColumnCount,
    BufferTooSmall,
};

pub fn convert(buffer: []u8, input: []const []const u8) RecognitionError![]u8 {
    if (input.len == 0 or input.len % 4 != 0) return RecognitionError.InvalidRowCount;

    const rows = input.len;
    const cols = input[0].len;

    if (cols % 3 != 0) return RecognitionError.InvalidColumnCount;

    const expected_len = (rows / 4) * (cols / 3) + (rows / 4 - 1);
    if (buffer.len < expected_len) return RecognitionError.BufferTooSmall;

    var row_idx: usize = 0;
    var buf_idx: usize = 0;

    while (row_idx < rows) : (row_idx += 4) {
        var col_idx: usize = 0;

        while (col_idx < cols) : (col_idx += 3) {
            const fst_line = input[row_idx][col_idx .. col_idx + 3];
            const snd_line = input[row_idx + 1][col_idx .. col_idx + 3];
            const trd_line = input[row_idx + 2][col_idx .. col_idx + 3];

            if (std.mem.eql(u8, fst_line, " _ ")) {
                if (std.mem.eql(u8, snd_line, "| |") and std.mem.eql(u8, trd_line, "|_|")) {
                    buffer[buf_idx] = '0';
                    buf_idx += 1;
                    continue;
                }
                if (std.mem.eql(u8, snd_line, " _|")) {
                    if (std.mem.eql(u8, trd_line, "|_ ")) {
                        buffer[buf_idx] = '2';
                        buf_idx += 1;
                        continue;
                    }
                    if (std.mem.eql(u8, trd_line, " _|")) {
                        buffer[buf_idx] = '3';
                        buf_idx += 1;
                        continue;
                    }
                }
                if (std.mem.eql(u8, snd_line, "|_ ")) {
                    if (std.mem.eql(u8, trd_line, " _|")) {
                        buffer[buf_idx] = '5';
                        buf_idx += 1;
                        continue;
                    }
                    if (std.mem.eql(u8, trd_line, "|_|")) {
                        buffer[buf_idx] = '6';
                        buf_idx += 1;
                        continue;
                    }
                }
                if (std.mem.eql(u8, snd_line, "  |") and std.mem.eql(u8, trd_line, "  |")) {
                    buffer[buf_idx] = '7';
                    buf_idx += 1;
                    continue;
                }
                if (std.mem.eql(u8, snd_line, "|_|")) {
                    if (std.mem.eql(u8, trd_line, "|_|")) {
                        buffer[buf_idx] = '8';
                        buf_idx += 1;
                        continue;
                    }
                    if (std.mem.eql(u8, trd_line, " _|")) {
                        buffer[buf_idx] = '9';
                        buf_idx += 1;
                        continue;
                    }
                }
            } else if (std.mem.eql(u8, fst_line, "   ")) {
                if (std.mem.eql(u8, snd_line, "  |") and std.mem.eql(u8, trd_line, "  |")) {
                    buffer[buf_idx] = '1';
                    buf_idx += 1;
                    continue;
                }
                if (std.mem.eql(u8, snd_line, "|_|") and std.mem.eql(u8, trd_line, "  |")) {
                    buffer[buf_idx] = '4';
                    buf_idx += 1;
                    continue;
                }
            }

            buffer[buf_idx] = '?';
            buf_idx += 1;
        }

        if (row_idx != rows - 4) {
            buffer[buf_idx] = ',';
            buf_idx += 1;
        }
    }

    return buffer[0..buf_idx];
}
