const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

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

    b.installArtifact(c_quicksort);
}
