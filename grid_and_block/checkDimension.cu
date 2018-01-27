//This is a practice code of checking the dimension and coordinate of 
//block and grid from both host and device
//Author: Maxwell Cui
//Jan 26, 2018

#include<stdio.h>

__global__ void checkIndex()
{
  printf("threadIdx:(%d, %d, %d) blockIdx:(%d, %d, %d)\nblockDim:(%d, %d, %d) gridDim:(%d, %d, %d)\n\n",threadIdx.x,threadIdx.y,threadIdx.z,blockIdx.x,blockIdx.y,blockIdx.z,blockDim.x,blockDim.y,blockDim.z,gridDim.x,gridDim.y,gridDim.z);
}

int main()
{
  //Number of elements
  int nElem=6;
  
  dim3 block (3);
  dim3 grid ((nElem+block.x-1)/block.x);

  printf("gird.x %d, gird.x %d, gird.x %d\n", grid.x, grid.y, grid.z);
  printf("block.x %d, block.x %d, block.x %d\n", block.x, block.y, block.z);

  checkIndex<<<grid,block>>>();

  cudaDeviceReset();

  return 0;
}
