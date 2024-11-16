const std = @import("std");

pub fn quicksort(data: []f32) callconv(.C) void {
    if (data.len == 0) return; // Handle edge case for empty array
    _quicksort(data, 0, @as(i32, @intCast(data.len)) - 1);
}

fn _quicksort(data: []f32, lo: i32, hi: i32) void {
    if (lo < hi) {
        const pivot: i32 = _partition(data, lo, hi);
        _quicksort(data, lo, pivot - 1);
        _quicksort(data, pivot + 1, hi);
    }
}

fn _partition(data: []f32, lo: i32, hi: i32) i32 {
    const pivot: f32 = data[@as(usize, @intCast(hi))];
    var i: i32 = lo;
    for (@as(usize, @intCast(lo))..@as(usize, @intCast(hi))) |j| {
        if (data[@as(usize, j)] < pivot) {
            // Swap data[i] and data[j]
            const tmp: f32 = data[@as(usize, @intCast(i))];
            data[@as(usize, @intCast(i))] = data[@as(usize, @intCast(j))];
            data[@as(usize, @intCast(j))] = tmp;
            i += 1;
        }
    }

    // Swap data[i] and data[hi] (put pivot in the correct position)
    const tmp: f32 = data[@as(usize, @intCast(i))];
    data[@as(usize, @intCast(i))] = data[@as(usize, @intCast(hi))];
    data[@as(usize, @intCast(hi))] = tmp;

    return i;
}

test "quicksort works" {
    var data = [_]f32{
        0.13681683672951306,
        0.7905094550709765,
        0.3252756667712565,
        0.2131963197688399,
        0.16932159094787846,
        0.11964511583749737,
        0.7777372448181608,
        0.35614796449114383,
        0.8232391705420822,
    };
    const expected_results = [_]f32{
        0.11964511583749737,
        0.13681683672951306,
        0.16932159094787846,
        0.2131963197688399,
        0.3252756667712565,
        0.35614796449114383,
        0.7777372448181608,
        0.7905094550709765,
        0.8232391705420822,
    };

    quicksort(data[0..]); // Pass the slice to quicksort

    try std.testing.expectEqualSlices(f32, expected_results[0..], data[0..]);
}
