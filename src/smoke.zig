const std = @import("std");

const zmime = @import("zmime");
pub fn main(init: std.process.Init) !void {
    const io = init.io;

    var stdout_buf: [1024]u8 = undefined;
    var stdout = std.Io.File.stdout().writer(io, &stdout_buf);
    const sw = &stdout.interface;

    try zmime.getMIME(sw, "README.md");
    try sw.writeByte('\n');
    try sw.flush();
}
