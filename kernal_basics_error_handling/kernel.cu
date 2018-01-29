//
//This is a code for the kernel basics and also the error handling
//Author: Zhaoyuan "Maxwell" Cui

#include<cuda_runtime.h>
#include<stdio.h>

#define CHECK(call)\
{\
  const cudaError_t error=call;\
  if(error!=cudaSuccess)\
    {\
      printf("Error: %s:%d, ", __FILE__, __LINE__);\
      printf("code:%d, reason: %s\n",error,cudaGetErrorString(error));\
      exit(1);\
    }\
}\

__global__ void kernel(float *A, float *B, float *C)
{
  int i;
  i=blockIdx.x*blockDim.x+threadIdx.x;
  C[i]=A[i]+B[i];
  printf("A: %f B:%f C:%f\n",A[i],B[i],C[i]);
}

int main()
{
  int nElm=100;
  float *h_A, *h_B, *h_C;
  int size=nElm*sizeof(float);
  h_A=(float*)malloc(size);
  h_B=(float*)malloc(size);
  h_C=(float*)malloc(size);

  for(int i=0;i<nElm;i++)
    {
      h_A[i]=1;
      h_B[i]=2;
      h_C[i]=0;
    }

  float *d_A,*d_B,*d_C;
  CHECK(cudaMalloc(&d_A,size));
  CHECK(cudaMalloc(&d_B,size));
  CHECK(cudaMalloc(&d_C,size));

  CHECK(cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice));
  CHECK(cudaMemcpy(d_B,h_B,size,cudaMemcpyHostToDevice));
  CHECK(cudaMemcpy(d_C,h_C,size,cudaMemcpyHostToDevice));
  
  dim3 block (10);
  dim3 grid ((nElm+block.x-1)/block.x);

  kernel<<<grid,block>>>(d_A,d_B,d_C);
  CHECK(cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost));

  for(int i=0;i<nElm;i++)
    {
      if(h_C[i]!=3)
      {
	printf("%f.\n",h_C[i]);
	printf("Calculation error!\n");
	exit(1);
      }
    }

  free(h_A);
  free(h_B);
  free(h_C);

  cudaFree(d_A);
  cudaFree(d_B);
  cudaFree(d_C);
  
  return 0;
  
}
