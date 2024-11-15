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
  "total_elapsed_time": 0.09425779998491635,
  "average": 0.0009425779998491634,
  "minimum": 0.0008194000001822133,
  "maximum": 0.0014331999991554767
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
  "total_elapsed_time": 0.013687299979210366,
  "average": 0.00013687299979210367,
  "minimum": 0.00012149999747634865,
  "maximum": 0.0002793000021483749
  // ...
}
```
