//This is a code for the kernel basics and also the error handling
//Author: Zhaoyuan "Maxwell" Cui

#include<cuda_runtime.h>
#include<stdio.h>

#define CHECK(call)
{
  const cudaError_t error=call;
  if(error!=cudaSuccess)
    {
      printf("Error: %s:%d, ", __FILE__, __LINE__);
      printf("code:%d, reason: %s\n",error,cudaGetErrorString(error));
      exit(1);
    }
}

__global__ kernel(int *A, int *B, int *C)
{
  int i;
  i=threadIdx.x;
  C[i]=A[i]+B[i];
}

int main()
{
  int nElm=100;
  int *h_A, *h_B, *h_C;
  int size=nElm*sizeof(float);
  h_A=malloc(size);
  h_B=malloc(size);
  h_C=malloc(size);

  for(int i=0;i<nElm;i++)
    {
      h_A[i]=1;
      h_B[i]=2;
      h_C[i]=0;
    }

  int *d_A,*d_B,*d_C;
  CHECK(cudaMalloc(&d_A,size));
  CHECK(cudaMalloc(&d_B,size));
  CHECK(cudaMalloc(&d_C,size));

  CHECK(cudaMemcoy(d_A,h_A,size,cudaMemcpyHostToDevice));
  CHECK(cudaMemcoy(d_B,h_B,size,cudaMemcpyHostToDevice));
  CHECK(cudaMemcoy(d_C,h_C,size,cudaMemcpyHostToDevice));
  
  dim3 block (10);
  dim3 grid ((nElm+block.x-1)/block.x);

  CHECK(kernel<<<grid,block>>>(d_A,d_B,d_C));
  CHECK(cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost));

  for(int i=0;i<nElm;i++)
    {
      if(h_C[i]!=3}
      {
	printf("Calculation error!\n");
	exit(1);
      }
    }
  
  return 0;
  
}
