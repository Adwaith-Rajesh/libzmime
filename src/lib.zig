const std = @import("std");
const Writer = std.Io.Writer;

const c_zmime = @import("c_zmime");

pub fn getMIME(w: *Writer, filepath: []const u8) !void {
    if (filepath.len > std.c.PATH_MAX) {
        return error.PathTooLong;
    }

    var sentinel_buffer: [std.c.PATH_MAX]u8 = undefined;
    var out_buf: [1024]u8 = undefined;
    var out_size: c_int = 0; // this is exact number of characters in out_buf

    const file_path_z = try std.fmt.bufPrintSentinel(&sentinel_buffer, "{s}", .{filepath}, 0);

    c_zmime.get_mime(file_path_z, &out_buf, &out_size);
    try w.writeSliceEndian(u8, out_buf[0..@intCast(out_size)], .big);
}
