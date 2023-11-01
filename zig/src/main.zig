const std = @import("std");

const cyberpunk = @import("sets/cyberpunk.zig");
const fairytale = @import("sets/fairytale.zig");
const loudmouth = @import("sets/loudmouth.zig");
const moneytalk = @import("sets/moneytalk.zig");
const numbers = @import("sets/numbers.zig");
const standard = @import("sets/standard.zig");

pub fn main() anyerror!void {
  std.log.info("The Zig version of karakter is a work in progress.", .{});
  const A = @field(cyberpunk.set, "A");
  const B = @field(fairytale.set, "B");
  const C = @field(loudmouth.set, "C");
  const D = @field(moneytalk.set, "D");
  const E = @field(numbers.set, "E");
  const F = @field(standard.set, "F");
  std.log.info("Examples:\n{s}\n{s}\n{s}\n{s}\n{s}\n{s}\n", .{A, B, C, D, E, F});
}

test "basic test" {
  try std.testing.expectEqual(10, 3 + 7);
}
