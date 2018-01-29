# Note

## Kernel
The kernal can be executed by calling
```
kernel_name<<<grid,block>>>(arguments);
```
where `gird` and `block` are the `dim3` variables we talked about in [Grid and block](../grid_and_block/README.md). It's important to note that the calling of kernal is a **_asynchronous process_** respect to the host function. That means the control returns to the host function right after the call of kernal. To wait for the kernal, one can use the `cudaDeviceSynchronize()` function. This will block the host process to wait for the kernal. Some other CUDA API has implicit synchronization, for example, `cudaMemcpy` starts copying after all kernel calls are finished.

There are three qualifiers for a kernel.

| Qualifier      | Execution | Callable                            |
| ---            | ---       | ---                                 |
| \_\_global\_\_ | device    | host or device(requires comp > 3.0) |
| \_\_device\_\_ | device    | device only                         |
| \_\_host\_\_   | host      | host only                           |

A kernal can be declared as both `host` and `device`:
```
__device__ __host__ kernel(){}
```
Several restrictions on the kernels:
- Acceess to device memory **memory**
- Kernal on in CUDA must have `void` return type. 

The result from the GPU can be verified by comparing it with the result from the CPU. Two userful to debug
- Use `printf` function with Fermi and later architecture GPU
- Assign `gird=1` and `block=1` such that the kernel runs as `kernel<1,1>`. It works as a sequential function now.

## Error handling
Most of the CUDA runtime API has return type of `cudaError_t` (at least in my knowledge), so we can define a macro handle the error.
```c
#define CHECK(call)\
{\
	const cudaError_t error=call;\
	if(error!=cudaSuccess)\
	{\
		printf("Error: %s:%d, ", __FILE__, __LINE__);\
		printf("code:%d, reason: %s\n",error,cudaGetErrorString(error));\
		exit(1);\
	}\
}
```
In case you are not familiar with Macro just like I was,`__FILE__` returns the file which is being executed and `__LINE__` returns the line that the program is being executed. Besides these to, `__func__` is also available.

To use the error handling macro, simply wrap the CUDA function with the `CHECK()` macro:
```C
CHECK(cudaMemcpy(h_C, d_C,sizeof(float),cudaMemcpyDeviceToHost));
```
It can also be used to check the kernel:
```C
kernel<<<grid,block>>>();
CHECK(cudaDeviceSynchronize());
```

