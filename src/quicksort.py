import ctypes
import time

c_quicksort = ctypes.cdll.LoadLibrary("zig-out/bin/c_quicksort.dll")


class CImpl:
    @staticmethod
    def quicksort(data: list[float]) -> float:
        c_data = (ctypes.c_float * len(data))(*data)
        c_array_pointer = ctypes.cast(c_data, ctypes.POINTER(ctypes.c_float))
        
        start = time.perf_counter()
        c_quicksort.quicksort(c_array_pointer, len(data))
        end = time.perf_counter()

        for i in range(len(data)):
            data[i] = c_data[i]

        return end - start

class PythonImpl:
    @staticmethod
    def quicksort(data: list[float]) -> float:
        # pre-shuffle data
        # random.shuffle(data)
        
        start = time.perf_counter()
        PythonImpl._quicksort(data, 0, len(data) - 1)
        end = time.perf_counter()
        return end - start

    @staticmethod
    def _quicksort(data: list[float], lo: int, hi: int) -> None:
        if lo < hi:
            pivot = PythonImpl._partition(data, lo, hi)
            PythonImpl._quicksort(data, lo, pivot - 1)
            PythonImpl._quicksort(data, pivot + 1, hi)

    @staticmethod
    def _partition(data: list[float], lo: int, hi: int) -> int:
        pivot = data[hi]
        i = lo - 1
        for j in range(lo, hi):
            if (data[j] < pivot):
                i += 1
                tmp = data[j]
                data[j] = data[i]
                data[i] = tmp
        
        tmp = data[i + 1]
        data[i + 1] = data[hi]
        data[hi] = tmp
        return i + 1
