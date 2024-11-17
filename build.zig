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
    const c_quicksort_install = b.step("c_quicksort", "Build the c_quicksort shared library.");
    c_quicksort_install.dependOn(&c_quicksort_artifact.step);

    // zig_quicksort
    const zig_quicksort = b.addSharedLibrary(.{
        .name = "zig_quicksort",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/quicksort.zig"),
    });

    const zig_quicksort_artifact = b.addInstallArtifact(zig_quicksort, .{});
    const zig_quicksort_install = b.step("zig_quicksort", "Build the zig_quicksort shared library.");
    zig_quicksort_install.dependOn(&zig_quicksort_artifact.step);

    // all
    const install_all = b.step("all", "Build all libraries.");
    install_all.dependOn(&c_quicksort_artifact.step);
    install_all.dependOn(&zig_quicksort_artifact.step);

    // run all algorithms via app.py
    const run_step = b.step("run", "Run the algorithms and gather results.");
    run_step.dependOn(&zig_quicksort_artifact.step);
    run_step.dependOn(&c_quicksort_artifact.step);
    const algorithm = &.{ "c_quicksort", "zig_quicksort", "py_quicksort" };
    inline for (algorithm) |algo| {
        const run_args: []const []const u8 = &.{ "python", "./app.py", "--num-iterations=10", "--num-elements=100000", "--algorithm=" ++ algo };
        const system_cmd = b.addSystemCommand(run_args);
        run_step.dependOn(&system_cmd.step);
    }
}
