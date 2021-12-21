const std = @import("std");

pub fn main() anyerror!void {
    std.log.info("The Zig version of karakter is a work in progress.", .{});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
