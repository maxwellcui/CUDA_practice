// This program will print out some of the properties of the GPU that is being used

#include<iostream>

int main()
{
  int deviceId;
  int warpSize;
  int computeCapabilityMajor;
  int computeCapabilityMinor;
  int multiProcessorCount;

  cudaGetDevice(&deviceId);

  cudaDeviceProp props;
  cudaGetDeviceProperties(&props,deviceId);

  warpSize=props.warpSize;
  computeCapabilityMajor=props.major;
  computeCapabilityMinor=props.minor;
  multiProcessorCount=props.multiProcessorCount;

  std::cout << "The device Id is: "<<deviceId
            << "\nThe major compute capability is: "<<computeCapabilityMajor
            << "\nThe minor compute capability is: "<<computeCapabilityMinor
            << "\nThe number of SM is: "<<multiProcessorCount
            << "\nThe warp size is: "<<warpSize<<std::endl;
}
