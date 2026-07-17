const std = @import("std");

pub fn response(s: []const u8) []const u8 {
      const trimmed = std.mem.trim(u8, s,
  &std.ascii.whitespace);
      if (trimmed.len == 0) return "Fine. Be that way!";

      const questioning = trimmed[trimmed.len - 1] == '?';

      var has_letter = false;
      var has_lower = false;
      for (trimmed) |c| {
          if (std.ascii.isAlphabetic(c)) has_letter = true;
          if (std.ascii.isLower(c)) has_lower = true;
      }
      const shouting = has_letter and !has_lower;

      if (shouting and questioning) return "Calm down, I know what I'm doing!";
      if (shouting) return "Whoa, chill out!";
      if (questioning) return "Sure.";
      return "Whatever.";
  }
