#include<iostream>

//#ifndef MATRIX_DIM
#define MATRIX_DIM 5

//__constant__ float d_mat[MATRIX_DIM][MATRIX_DIM];

int main()
{
  //Declare matrix on host
  float mat[MATRIX_DIM][MATRIX_DIM];
  std::cout<<"hi\n";
  //Initilize matrix
  for(int i=0;i<MATRIX_DIM;i++)
    {
      for(int j=0;j<MATRIX_DIM;i++)
	{
	  if(i==j)
	    {
	      mat[i][j]=1;
	    }
	  else
	    {
	      mat[i][j]=0;
	    }	
	}
    }

  std::cout<<"The matrix is :"<<std::endl;
  for(int i=0;i<MATRIX_DIM;i++)
    {
      for(int j=0;j<MATRIX_DIM;j++)
	{
	  std::cout<<"%3"<<mat[i][j];
	}
      std::cout<<std::endl;
    }

  return 0;
}
