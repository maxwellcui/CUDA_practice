//A practice code of using constant memory in dot product
//Author: Zhaoyuan "Maxwell" Cui
//Jun 13, 2017

#include<stdio.h>
#include<iostream>

#define VEC_DIM 120

//Define constant memory
__constant__ float d_vec[VEC_DIM];


//Prototype the kernal
__global__ void kernal(float* input,float* d_result);

int main()
{
  //Declare variables on host and device
  float *c_vec=new float [VEC_DIM];
  float *c_result=new float;
  float *d_result,*d_input;
  
  //Allocate memory for device variable
  cudaMalloc(&d_result,sizeof(float));
  cudaMalloc(&d_input,sizeof(float)*VEC_DIM);

  //Initialize host vector
  for(int i=0;i<VEC_DIM;i++)
    {
      c_vec[i]=1;
    }

  //Copy memory to constant memory
  cudaMemcpyToSymbol(d_vec,c_vec,sizeof(float)*VEC_DIM);

  //Copy memory to device input vector
  cudaMemcpy(d_input,c_vec,sizeof(float)*VEC_DIM,cudaMemcpyHostToDevice);

  //RUN!!
  kernal<<<1,VEC_DIM>>>(d_input,d_result);

  //Copy result from device to host
  cudaMemcpy(c_result,d_result,sizeof(float),cudaMemcpyDeviceToHost);

  //SYNC...
  cudaDeviceSynchronize();

  //Show the result
  std::cout<<"The result is: "<<*c_result<<std::endl;

  //Free allocated memory
  delete [] c_vec;
  delete c_result;
  cudaFree(d_result);
  cudaFree(d_input);

  return 0;
}

__global__ void kernal(float* d_input,float* d_result)
{
  //Declare and acquire thread id
  int tid;
  tid=blockIdx.x*blockDim.x+threadIdx.x;
  
  //Declare shared memory
  __shared__ float cache[VEC_DIM];
  
  //do the calculation
  if(tid<VEC_DIM)
    {
      cache[tid]=d_input[tid]*d_vec[tid];
    }

  //Wait for all threads
  __syncthreads();

  //Initialize the return variable
  *d_result=0;

  //Caluclate the result
  for(int i=0;i<VEC_DIM;i++)
    {
      *d_result+=cache[i];
    }
}
