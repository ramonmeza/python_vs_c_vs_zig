# Algorithm Performance Showdown

A performance comparison test on different algorithms implemented in Python, C,
and Zig.

## `app.py`

`app.py` is a simple application used to run a number of tests utilizing the
specified algorithm and language implementation. The application will load the
C and Zig libraries using `ctypes`, run the algorithm a number of times, and
report the following statistics:

- Overall run time
- Average time of each iteration
- Fastest iteration time
- Slowest iteration time
- Median iteration time

The application is able to be configured by utilizing the CLI arguments:

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

## App

[Source File](app.py)

This application takes in the CLI arguments, creates a `TestReport`, creates randomized test data and passes that data to the algorithm. The `TestReport` is then saved, which saves data related to the tests in JSON format into a `reports` subdirectory.

## Sorting Algorithms

### Quicksort

| Argument         | Value |
| ---------------- | ----- |
| `num_iterations` | 100   |
| `num_elements`   | 1000  |

#### Python Results

[Source File](src/quicksort.py)

```json
{
  "algorithm": "py_quicksort",
  "num_iterations": 100,
  "num_elements": 1000,
  "total_elapsed_time": 0.273996900068596,
  "average": 0.00273996900068596,
  "minimum": 0.002459099981933832,
  "maximum": 0.004111699992790818
  // ...
}
```

#### C implementation

[Source File](src/quicksort.c)

```json
{
  "algorithm": "c_quicksort",
  "num_iterations": 100,
  "num_elements": 1000,
  "total_elapsed_time": 0.03397339989896864,
  "average": 0.0003397339989896864,
  "minimum": 0.00025779998395591974,
  "maximum": 0.000526399991940707
  // ...
}
```
