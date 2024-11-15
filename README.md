# Algorithm Performance Showdown

A performance comparison test on different algorithms implemented in Python, C,
and Zig.

## `app.py`

[Source File](app.py)

This application takes in the CLI arguments, creates a `TestReport`, creates
randomized test data and passes that data to the algorithm. The `TestReport` is
then saved, which saves data related to the tests in JSON format into a `reports`
subdirectory.

### CLI Usage

```sh
usage: app.py [-h] [--num-iterations NUM_ITERATIONS] [--num-elements NUM_ELEMENTS] [--algorithm {c_quicksort,py_quicksort}]

options:
  -h, --help            show this help message and exit
  --num-iterations, -n NUM_ITERATIONS
                        Number of iterations to run for each algorithm.
  --num-elements, -e NUM_ELEMENTS
                        Number of elements in the test data used as input for each algorithm.
  --algorithm, -a {c_quicksort,py_quicksort}
                        The algorithm to test.
```

## `build.zig`

You will need to build the C libraries and Zig libraries using `zig build`. For 
more advanced usage, utilize the CLI arguments.

### CLI Usage
```sh
Usage: zig build [steps] [options]

Steps:
  install (default)            Copy build artifacts to prefix path
  uninstall                    Remove build artifacts from prefix path
  c_quicksort                  Create the c_quicksort shared library.
  zig_quicksort                Create the zig_quicksort shared library.
```

## Sorting Algorithms

### Quicksort

| Argument         | Value |
| ---------------- | ----- |
| `num_iterations` | 100   |
| `num_elements`   | 1000  |

#### `PythonImpl` Results

[Source File](src/quicksort.py)

```json
{
  "algorithm": "py_quicksort",
  "num_iterations": 100,
  "num_elements": 1000,
  "total_elapsed_time": 0.09425779998491635,
  "average": 0.0009425779998491634,
  "minimum": 0.0008194000001822133,
  "maximum": 0.0014331999991554767
}
```

#### `CImpl` Results

[Source File](src/quicksort.c)

```json
{
  "algorithm": "c_quicksort",
  "num_iterations": 100,
  "num_elements": 1000,
  "total_elapsed_time": 0.013687299979210366,
  "average": 0.00013687299979210367,
  "minimum": 0.00012149999747634865,
  "maximum": 0.0002793000021483749
}
```

#### `ZigImpl` Results

[Source File](src/quicksort.zig)

```json
// @todo
```
