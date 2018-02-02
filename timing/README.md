# Note
Timing is a useful technique to measure the efficiency of the program run on GPU. There are several different ways to study the time consumption. The method I mention here is the `nvprof` command-line profiling tool. Other methods will be added later on. To use this tool, simply put `nvprof` in front of your executable:
```shell
$ nvprof [nvprof_args] <application> [application_args]
```
## Example output
Here is the output of a vector dot product example from the [here](../vector_dot_product). Please ignore the third line about the time. It's from a different timing method of `cudaEvent_t`. The output from the `nvprof` starts from line 5.
```shell
$ nvprof ./vector_non_reduction
The result of the dot product from the GPU is: 800
	-Time of calculation on GPU is:0.01952[ms]

The result of the dot product from the CPU is: 800
==30719== Profiling application: ./vecDot_non_reduction
==30719== Profiling result:
Time(%)      Time     Calls       Avg       Min       Max  Name
 35.26%  1.9520us         3     650ns     576ns     736ns  [CUDA memcpy HtoD]
 35.26%  1.9520us         1  1.9520us  1.9520us  1.9520us  dot(float*, float*, float*)
 29.48%  1.6320us         1  1.6320us  1.6320us  1.6320us  [CUDA memcpy DtoH]

==30719== API calls:
Time(%)      Time     Calls       Avg       Min       Max  Name
 99.17%  60.741ms         2  30.370ms     815ns  60.740ms  cudaEventCreate
  0.38%  232.29us        83  2.7980us      84ns  110.03us  cuDeviceGetAttribute
  0.16%  100.11us         3  33.370us  4.1230us  89.350us  cudaMalloc
  0.11%  66.386us         3  22.128us  3.9460us  55.529us  cudaFree
  0.05%  31.129us         1  31.129us  31.129us  31.129us  cuDeviceTotalMem
  0.05%  30.765us         4  7.6910us  4.2450us  12.919us  cudaMemcpy
  0.04%  21.921us         1  21.921us  21.921us  21.921us  cuDeviceGetName
  0.02%  12.479us         1  12.479us  12.479us  12.479us  cudaLaunch
  0.01%  3.9500us         1  3.9500us  3.9500us  3.9500us  cudaEventSynchronize
  0.01%  3.2210us         2  1.6100us  1.3090us  1.9120us  cudaEventRecord
  0.00%  2.0430us         3     681ns     155ns  1.6130us  cudaSetupArgument
  0.00%  1.9610us         2     980ns     434ns  1.5270us  cudaEventDestroy
  0.00%  1.2850us         1  1.2850us  1.2850us  1.2850us  cudaEventElapsedTime
  0.00%     756ns         1     756ns     756ns     756ns  cudaConfigureCall
  0.00%     716ns         2     358ns     148ns     568ns  cuDeviceGetCount
  0.00%     269ns         2     134ns      82ns     187ns  cuDeviceGet
```
