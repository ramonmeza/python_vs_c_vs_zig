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
usage: app.py [-h] [--num-iterations NUM_ITERATIONS] [--num-elements NUM_ELEMENTS] [--algorithm {c_quicksort,py_quicksort,zig_quicksort}]

options:
  -h, --help            show this help message and exit
  --num-iterations, -n NUM_ITERATIONS
                        Number of iterations to run for each algorithm.
  --num-elements, -e NUM_ELEMENTS
                        Number of elements in the test data used as input for each algorithm.
  --algorithm, -a {c_quicksort,py_quicksort,zig_quicksort}
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
  c_quicksort                  Build the c_quicksort shared library.
  zig_quicksort                Build the zig_quicksort shared library.
  all                          Build all libraries.
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
  "num_elements": 100,
  "total_elapsed_time": 0.005717000021832064,
  "average": 5.717000021832064e-5,
  "minimum": 5.169999349163845e-5,
  "maximum": 6.859999848529696e-5
}
```

#### `CImpl` Results

[Source File](src/quicksort.c)

```json
{
  "algorithm": "c_quicksort",
  "num_iterations": 100,
  "num_elements": 100,
  "total_elapsed_time": 0.0009697000132291578,
  "average": 9.697000132291578e-6,
  "minimum": 8.499999239575118e-6,
  "maximum": 2.8599999495781958e-5
}
```

#### `ZigImpl` Results

[Source File](src/quicksort.zig)

```json
{
  "algorithm": "zig_quicksort",
  "num_iterations": 100,
  "num_elements": 100,
  "total_elapsed_time": 0.0009589999754098244,
  "average": 9.589999754098244e-6,
  "minimum": 8.200004231184721e-6,
  "maximum": 2.7099995349999517e-5
}
```
