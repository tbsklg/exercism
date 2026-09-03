const std = @import("std");
const starting = [_][]const u8{
    "This is the house that Jack built.",
    "This is the malt",
    "This is the rat",
    "This is the cat",
    "This is the dog",
    "This is the cow with the crumpled horn",
    "This is the maiden all forlorn",
    "This is the man all tattered and torn",
    "This is the priest all shaven and shorn",
    "This is the rooster that crowed in the morn",
    "This is the farmer sowing his corn",
    "This is the horse and the hound and the horn",
};

const ending = [_][]const u8{
    "that lay in the house that Jack built.",
    "that ate the malt",
    "that killed the rat",
    "that worried the cat",
    "that tossed the dog",
    "that milked the cow with the crumpled horn",
    "that kissed the maiden all forlorn",
    "that married the man all tattered and torn",
    "that woke the priest all shaven and shorn",
    "that kept the rooster that crowed in the morn",
    "that belonged to the farmer sowing his corn",
};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    var writer: std.Io.Writer = .fixed(buffer);

    for ((start_verse - 1)..end_verse) |i| {
        _ = try writer.write(starting[i]);

        for (0..i) |j| {
            _ = try writer.write(" ");
            _ = try writer.write(ending[i - j - 1]);
        }

        if ((i + 1) < end_verse) {
            _ = try writer.write("\n");
        }
    }

    return writer.buffered();
}
