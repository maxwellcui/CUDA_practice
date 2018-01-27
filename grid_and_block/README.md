# Note
This code studys the dimension of grid, block, and thread. When kernal is invoked, CUDA automatically assign coordinates to thread, block, and grid. These are pre-initialized variables. There are two different variables for the dimension `unit3` and `dim3`. `unit3` is a structure build upon the regular unsigned interger. `dim3` is derived from the `unit3` structure. To initialize the size of grid (1D) and block (1D) on the host, one can simply use the following code. 
```
dim3 block (n);
dim3 gird (nElm+block.x-1/block.x);
```
Grid is usually in the size of 2D array, and blcok is usually in the size of 3D array. Both grid and block are declared as `dim3` and when the dimension is not specified, it is automatically initialized as 1.
It's important to note that one accesses the coordinate differently from the host and the device.
## Device
To access the coordinate and size, one can use the following code
```
threadIdx.x
threadIdx.y
threadIdx.z
blockIdx.x
blockIdx.y
blockIdx.z
blockDim.x
blockDim.y
blockDim.z
gridDim.x
gridDim.y
gridDim.z
```
The variables `threadIdx`, `blockIdx`, `blockDim`, and `gridDim` are all assigned by CUDA automatically and only visiable on device.
## Host
To access the coordinate, one can use the following code
```
block.x
block.y
block.z
grid.x
grid.y
grid.z
``` 
Both `block` and `grid` are only visiable on the host.