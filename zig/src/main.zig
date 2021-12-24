const std = @import("std");

const cyberpunk = @import("sets/cyberpunk.zig");
const fairytale = @import("sets/fairytale.zig");
const standard = @import("sets/standard.zig");

pub fn main() anyerror!void {
  std.log.info("The Zig version of karakter is a work in progress.", .{});
  const A = @field(cyberpunk.set, "A");
  const B = @field(fairytale.set, "B");
  const C = @field(standard.set, "C");
  std.log.info("Examples:\n{s}\n{s}\n{s}\n", .{A, B, C});
}

test "basic test" {
  try std.testing.expectEqual(10, 3 + 7);
}
