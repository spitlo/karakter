const std = @import("std");

const Set = struct {
    A: []const u8,
    B: []const u8,
    C: []const u8,
};

var cyberpunk = Set{
    .A = "ΔΛА▲4",
    .B = "8",
    .C = "©",
};

pub fn main() anyerror!void {
    std.log.info("The Zig version of karakter is a work in progress.", .{});
    std.log.info("{s}\n", .{cyberpunk.A});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
