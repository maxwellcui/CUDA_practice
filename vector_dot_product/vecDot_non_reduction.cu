//This is practice code of using cuda to do vector dot product without reduction of array
//Author: Zhaoyuan "Maxwell" Cui
//May 30, 2017

//Define certain parameters that will be used across the application
# define N 100 //The size of the vector
# define blockSize 10 
# define threadSize 10

#include<iostream>
#include<ctime>

//Prototype of the GPU kernal
__global__ void dot(float *a, float *b, float *c);

int main()
{
  //Declare CUDA event that will evaluate the performance of the code
  cudaEvent_t start,stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  //Declare variables in the host
  float *a,*b,*c,*d;
  float size_ab,size_c;
  
  //Allocate memory and initialize variables
  size_ab=sizeof(float)*N;
  size_c=sizeof(float)*blockSize;

  a=(float*)malloc(size_ab);
  b=(float*)malloc(size_ab);
  c=(float*)malloc(size_c);
  d=(float*)malloc(size_ab);

  for(int i=0;i<N;i++)
    {
      a[i]=4;
      b[i]=2;
    }

  for(int i=0;i<blockSize;i++)
    {
      c[i]=0;
      d[i]=0;
    }

  //Declare variables in the device
  float *d_a, *d_b, *d_c;

  //Allocate memory 
  cudaMalloc(&d_a,size_ab);
  cudaMalloc(&d_b,size_ab);
  cudaMalloc(&d_c,size_c);

  //Copy the data of the host variables to the device variables
  cudaMemcpy(d_a,a,size_ab,cudaMemcpyHostToDevice);
  cudaMemcpy(d_b,b,size_ab,cudaMemcpyHostToDevice);
  cudaMemcpy(d_c,c,size_c,cudaMemcpyHostToDevice);

  //Start event records
  cudaEventRecord(start,0);

  //Launch kernal
  dot<<<blockSize,threadSize>>>(d_a,d_b,d_c);

  //Stop event records and sync
  cudaEventRecord(stop,0);
  cudaEventSynchronize(stop);

  //Calculate the elapsed time
  float elapsedTime;
  cudaEventElapsedTime(&elapsedTime,start,stop);
  
  //Copy the result from the device variable back to the host variable
  cudaMemcpy(c,d_c,size_c,cudaMemcpyDeviceToHost);

  //Calculate the final result from the GPU  
  float result;
  result=0;

  for(int i=0;i<blockSize;i++)
    {
      result+=c[i];
    }

  std::cout<<"The result of the dot product from the GPU is: "<<result<<std::endl;
  std::cout<<"\t-Time of calculation on GPU is:"<<elapsedTime<<"[ms]\n\n";
  
  cudaEventDestroy(start);
  cudaEventDestroy(stop);
  
  //Do the dot product on the CPU to varify the answer
  result=0;
  for(int i=0;i<N;i++)
    {
      d[i]=a[i]*b[i];
    }

  for(int i=0;i<N;i++)
    {
      result+=d[i];
    }

  std::cout<<"The result of the dot product from the CPU is: "<<result<<std::endl;
 
  //Free the variables
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  free(a);
  free(b);
  free(c);
  free(d);

  return 0;
}

__global__ void dot(float *a, float *b, float *c)
{
  //Calculate and assign the thread id
  int tid;
  tid=blockDim.x*blockIdx.x+threadIdx.x;
  
  //Declare the shared memory inside a block
  __shared__ float cache[threadSize];
  
  //Declare a tempory variable to hold data
  float temp;

  if(tid<N)
    {
      temp=a[tid]*b[tid];
      cache[threadIdx.x]=temp;
    }

  //Wait for all the threads
  __syncthreads();
  
  //Calculate the sum of the product inside a block
  for(int i=0;i<threadSize;i++)
    {
      c[blockIdx.x]+=cache[i];
    }
}
