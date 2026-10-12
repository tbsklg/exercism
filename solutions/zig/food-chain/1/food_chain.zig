const std = @import("std");

const verses = [_][]const u8{
    \\I know an old lady who swallowed a fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a spider.
    \\It wriggled and jiggled and tickled inside her.
    \\She swallowed the spider to catch the fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a bird.
    \\How absurd to swallow a bird!
    \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    \\She swallowed the spider to catch the fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a cat.
    \\Imagine that, to swallow a cat!
    \\She swallowed the cat to catch the bird.
    \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    \\She swallowed the spider to catch the fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a dog.
    \\What a hog, to swallow a dog!
    \\She swallowed the dog to catch the cat.
    \\She swallowed the cat to catch the bird.
    \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    \\She swallowed the spider to catch the fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a goat.
    \\Just opened her throat and swallowed a goat!
    \\She swallowed the goat to catch the dog.
    \\She swallowed the dog to catch the cat.
    \\She swallowed the cat to catch the bird.
    \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    \\She swallowed the spider to catch the fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a cow.
    \\I don't know how she swallowed a cow!
    \\She swallowed the cow to catch the goat.
    \\She swallowed the goat to catch the dog.
    \\She swallowed the dog to catch the cat.
    \\She swallowed the cat to catch the bird.
    \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    \\She swallowed the spider to catch the fly.
    \\I don't know why she swallowed the fly. Perhaps she'll die.
    ,
    \\I know an old lady who swallowed a horse.
    \\She's dead, of course!
};

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    var writer = std.Io.Writer.fixed(buffer);

    var i: u32 = start_verse;
    while (i <= end_verse) : (i += 1) {
        try writer.writeAll(verses[i - 1]);
        
        if (i < end_verse) {
            try writer.writeAll("\n\n");
        }
    }

    return writer.buffered();
}
