# Notes
The file `vecDot_non_reduction.cu' uses the shared memory, but do not use the reduction method. CUDA event is used to calculate the run time on the GPU

## To compile
```
nvcc vecDot_non_reduction.cu -o vecDot_non_reduction
```
