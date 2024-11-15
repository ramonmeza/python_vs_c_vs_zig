const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // c_quicksort
    const c_quicksort = b.addSharedLibrary(.{
        .name = "c_quicksort",
        .target = target,
        .optimize = optimize,
    });
    c_quicksort.addCSourceFile(.{
        .file = b.path("src/quicksort.c"),
    });
    c_quicksort.addIncludePath(b.path("src"));
    c_quicksort.linkLibC();

    const c_quicksort_artifact = b.addInstallArtifact(c_quicksort, .{});
    const c_quicksort_install = b.step("c_quicksort", "Create the c_quicksort shared library.");
    c_quicksort_install.dependOn(&c_quicksort_artifact.step);

    // zig_quicksort
    const zig_quicksort = b.addSharedLibrary(.{
        .name = "zig_quicksort",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/quicksort.zig"),
    });

    const zig_quicksort_artifact = b.addInstallArtifact(zig_quicksort, .{});
    const zig_quicksort_install = b.step("zig_quicksort", "Create the zig_quicksort shared library.");
    zig_quicksort_install.dependOn(&zig_quicksort_artifact.step);
}
