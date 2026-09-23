const std = @import("std");
const mem = std.mem;

pub fn translate(allocator: mem.Allocator, phrase: []const u8) ![]u8 {
    var out = std.Io.Writer.Allocating.init(allocator);
    defer out.deinit();

    var iter = mem.splitScalar(u8, phrase, ' ');

    while (iter.next()) |w| {
        try transform(&out.writer, w);

        if (iter.peek() != null) {
            _ = try out.writer.writeByte(' ');
        }
    }

    return out.toOwnedSlice();
}

fn transform(writer: *std.Io.Writer, word: []const u8) !void {
    if (word.len == 0) return;

    var index: usize = 0;

    if (!is_vowel(word[0]) and
        !mem.startsWith(u8, word, "xr") and
        !mem.startsWith(u8, word, "yt"))
    {
        while (index < word.len) : (index += 1) {
            const curr = word[index];

            if (curr == 'q' and
                index + 1 < word.len and
                word[index + 1] == 'u')
            {
                index += 2;
                break;
            }

            if (curr == 'y' and index != 0)
                break;

            if (is_vowel(curr))
                break;
        }
    }

    try writer.writeAll(word[index..]);
    try writer.writeAll(word[0..index]);
    try writer.writeAll("ay");
}

fn is_vowel(x: u8) bool {
    return x == 'a' or x == 'e' or x == 'i' or x == 'o' or x == 'u';
}
