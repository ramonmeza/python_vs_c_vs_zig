import argparse
import dataclasses
import datetime
import json
import os
import random
import sys

from src import quicksort


algorithms = {
    "c_quicksort": quicksort.CImpl.quicksort,
    "py_quicksort": quicksort.PythonImpl.quicksort,
    "zig_quicksort": quicksort.CImpl.quicksort,
}


@dataclasses.dataclass
class TestReport:
    algorithm: str = "None"
    num_iterations: int = 0
    num_elements: int = 0
    input_test_data: list[float] = dataclasses.field(default_factory=lambda: [])
    output_test_data: list[float] = dataclasses.field(default_factory=lambda: [])
    results: list[float] = dataclasses.field(default_factory=lambda: [])

    def save(self) -> None:
        timestamp = datetime.datetime.now()
        if not os.path.exists("reports"):
            os.mkdir("reports")

        filename = f'reports/{self.algorithm}_report_{timestamp.strftime("%d-%m-%Y_%H%M%S")}.json'
        print(f"Saving test report to {filename}")
        with open(
            filename,
            "w",
        ) as fp:
            json.dump(self._to_dict(), fp, indent=4)

    def _to_dict(self) -> dict:
        return {
            "algorithm": self.algorithm,
            "num_iterations": self.num_iterations,
            "num_elements": self.num_elements,
            "total_elapsed_time": self.total_elapsed_time,
            "average": self.average,
            "minimum": self.minimum,
            "maximum": self.maximum,
            "input_test_data": self.input_test_data,
            "output_test_data": self.output_test_data,
            "results": self.results,
        }

    @property
    def average(self) -> float:
        return self.total_elapsed_time / len(self.results)

    @property
    def minimum(self) -> float:
        return min(self.results)

    @property
    def maximum(self) -> float:
        return max(self.results)

    @property
    def total_elapsed_time(self) -> float:
        return sum(self.results)

    def __str__(self) -> str:
        s = f"Results using {self.algorithm} on {self.num_elements} random elements over {self.num_iterations} iterations\n"
        s += f"\tAverage (s): {self.average}\n"
        s += f"\tMinimum (s): {self.minimum}\n"
        s += f"\tMaximum (s): {self.maximum}\n"
        return s


def main(num_iterations: int, algorithm: str, num_elements: int) -> int:
    print(f"Run {num_iterations} test using {algorithm}...")

    # run tests
    test_report = TestReport(
        num_iterations=num_iterations, num_elements=num_elements, algorithm=algorithm
    )
    for i in range(num_iterations):
        # generate random test data and ensure its not sorted
        test_data = [random.random() for _ in range(num_elements)]
        assert test_data != sorted(
            test_data
        ), "test_data is sorted before being passed to the algorithm!"

        test_report.input_test_data.append(test_data.copy())

        # start the test
        elapsed = algorithms[algorithm](test_data)

        # ensure data is actually sorted
        assert test_data == sorted(test_data), "Resulting test_data is not sorted!"
        test_report.output_test_data.append(test_data.copy())

        # append results
        test_report.results.append(elapsed)

    # report results
    print(str(test_report))
    test_report.save()

    return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--num-iterations",
        "-n",
        help="Number of iterations to run for each algorithm.",
        action="store",
        default=100,
        type=int,
        required=False,
        dest="num_iterations",
    )
    parser.add_argument(
        "--num-elements",
        "-e",
        help="Number of elements in the test data used as input for each algorithm.",
        action="store",
        default=100,
        type=int,
        required=False,
        dest="num_elements",
    )
    parser.add_argument(
        "--algorithm",
        "-a",
        help="The algorithm to test.",
        action="store",
        default="c_quicksort",
        choices=[
            "c_quicksort",
            "py_quicksort",
            "zig_quicksort",
        ],
        type=str,
        required=False,
        dest="algorithm",
    )
    args = parser.parse_args()
    sys.exit(main(args.num_iterations, args.algorithm, args.num_elements))
