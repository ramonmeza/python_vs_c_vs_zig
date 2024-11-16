#include "quicksort.h"

void _quicksort(float *data, int lo, int hi);
int _partition(float *data, int lo, int hi);

void quicksort(float *data, int len) {
    _quicksort(data, 0, len - 1);
}

void _quicksort(float *data, int lo, int hi) {
    if(lo < hi) {
        int pivot = _partition(data, lo, hi);
        _quicksort(data, lo, pivot - 1);
        _quicksort(data, pivot + 1, hi);
    }
}

int _partition(float *data, int lo, int hi) {
    float pivot = data[hi];
    int i = lo - 1;
    for(int j = lo; j < hi; j++) {
        if(data[j] < pivot) {
            i += 1;

            float tmp = data[i];
            data[i] = data[j];
            data[j] = tmp;
        }
    }
    
    float tmp = data[i + 1];
    data[i + 1] = data[hi];
    data[hi] = tmp;
    
    return i + 1;
}
