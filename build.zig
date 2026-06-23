const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const system_magic_h = b.addTranslateC(.{
        .optimize = optimize,
        .target = target,
        .root_source_file = b.path("src/c/zmime.c"),
        .link_libc = true,
    });

    system_magic_h.linkSystemLibrary("magic", .{ .needed = true });

    const lib = b.addModule("zmime", .{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "c_zmime", .module = system_magic_h.createModule() },
        },
    });

    // smoke exe
    const smoke = b.addExecutable(.{
        .name = "smoke",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/smoke.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zmime", .module = lib },
            },
        }),
    });

    b.installArtifact(smoke);

    const smoke_step = b.step("smoke", "run the smoke exe");
    const run_smoke_cmd = b.addRunArtifact(smoke);
    smoke_step.dependOn(&run_smoke_cmd.step);

    // some tests
    const lib_main_test = b.addTest(.{
        .root_module = lib,
        .name = "lib_main_test",
    });

    const run_test_cmd = b.addRunArtifact(lib_main_test);
    const run_test_step = b.step("test", "Run the test");
    run_test_step.dependOn(&run_test_cmd.step);
}
