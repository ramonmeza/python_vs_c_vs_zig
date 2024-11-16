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
  "num_elements": 1000,
  "total_elapsed_time": 0.09324749999359483,
  "average": 0.0009324749999359483,
  "minimum": 0.0007798000006005168,
  "maximum": 0.0015515000050072558
}
```

#### `CImpl` Results

[Source File](src/quicksort.c)

```json
{
  "algorithm": "c_quicksort",
  "num_iterations": 100,
  "num_elements": 1000,
  "total_elapsed_time": 0.01527510002051713,
  "average": 0.0001527510002051713,
  "minimum": 0.00012479999713832512,
  "maximum": 0.00027260000206297264
}
```

#### `ZigImpl` Results

[Source File](src/quicksort.zig)

```json
{
  "algorithm": "zig_quicksort",
  "num_iterations": 100,
  "num_elements": 1000,
  "total_elapsed_time": 0.013725400021940004,
  "average": 0.00013725400021940003,
  "minimum": 0.00012479999713832512,
  "maximum": 0.00026839999918593094
}
```

## Join the Conversation

If you have comments or suggestions, or just want to lurk around the thread for
this repo, check it out on [Ziggit](https://ziggit.dev/t/comparing-python-zig-and-c/6883).

https://ziggit.dev/t/comparing-python-zig-and-c/6883
