const std = @import("std");
const c_zmime = @import("c_zmime");

pub fn getMime() void {
    std.debug.print("foo\n", .{});
    c_zmime.foo();
}

test "something" {
    std.testing.expect(1 == 1);
}
