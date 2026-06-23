# LibZMIME

---

A simple wrapper around `libmagic` and exposes a single function `getMIME`, which gives the MIME Type of a file.

###### As with all projects, new features will be added when I need them :)

---

## Dependencies

I hate it, but here are the dependencies that you need

- Debian/Ubuntu

```console
apt install libmagic-dev
```

---

## Installing

To use this library in your project just do

###### Min [Zig](https://ziglang.org/) Version 0.16.0

### Getting LibZMIME

```
zig fetch --save https://codeberg.org/Adwaith-Rajesh/libzmime/archive/v0.1.0.tar.gz
```

### Build.Zig

```zig
const zmime_dep = b.dependency("libzmime", .{
    .target = target,
    .optimize = optimize,
});
```

### Usage

```zig
const std = @import("std");

const zmime = @import("zmime");

pub fn main(init: std.process.Init) !void {
    const io = init.io;

    // we are writing to stdout in this example
    var stdout_buf: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(io, &stdout_buf);
    const sw = &stdout_writer.interface;

    try zmime.getMIME(sw, "filename");
    try sw.writeByte('\n');
    try sw.flush();
}
```

<details>
<summary>Output</summary>

> If the file is a plain text file

```console
text/plain
```
</details>

---

If you have any issue, please create an issue in the [Issue Tracker](https://codeberg.org/Adwaith-Rajesh/libzmime/issues) or join the [Discord Server](https://discord.gg/BxMbWzZe2Z)

### Byeee...
