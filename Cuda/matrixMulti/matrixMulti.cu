// nvcc matrixMulti.cu -o a && ./a
#include <stdio.h>
#include <stdlib.h>

#define WIDTH 3

__global__ void matrixMulKernelSimple(float* M, float* N, float* P, int width)
{
	// Simple kernel, accessing global memory too much! (Probabily using less than 1% of the total GPU power due to limited memory communication bandwidth)
	int col = blockDim.x*blockIdx.x + threadIdx.x;
	int row = blockDim.y*blockIdx.y + threadIdx.y;

	float res=0;
	if(col<width && row<width)
	{
		for(int i=0; i<width; i++)
			res += M[row*width+i]*N[i*width+col];

		P[row*width+col] = res;
	}
}

int main()
{
	float *d_M, *d_N, *d_P;
	float *h_M, *h_N, *h_P;

	int id = cudaGetDevice(&id);
	printf("GPU id: %d\n",id);

	// Alloc memory CPU
	h_M = (float*)malloc(WIDTH*WIDTH*sizeof(float));
	h_N = (float*)malloc(WIDTH*WIDTH*sizeof(float));
	h_P = (float*)malloc(WIDTH*WIDTH*sizeof(float));

	// Alloc memory GPU
	cudaMalloc((void**)&d_M, WIDTH*WIDTH*sizeof(float));
	cudaMalloc((void**)&d_N, WIDTH*WIDTH*sizeof(float));
	cudaMalloc((void**)&d_P, WIDTH*WIDTH*sizeof(float));

	// Populate matrices
	for(int i=0;i<WIDTH*WIDTH;i++)
	{
		h_M[i]=i;
		h_N[i]=2*i;
		h_P[i]=0;
	}

	// Copy from CPU to GPU
	cudaMemcpy(d_M, h_M, WIDTH*WIDTH*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(d_N, h_N, WIDTH*WIDTH*sizeof(float), cudaMemcpyHostToDevice);

	dim3 gridDim3 = dim3(1,1,1);
	dim3 blockDim3 = dim3(ceil(WIDTH/32.0f)*32, ceil(WIDTH/32.0f)*32,1);
	matrixMulKernelSimple<<<gridDim3, blockDim3>>>(d_M,d_N,d_P, WIDTH);
	
	// Copy from GPU to CPU
	cudaMemcpy(h_P, d_P, WIDTH*WIDTH*sizeof(float), cudaMemcpyDeviceToHost);

	// Print
	for(int i=0;i<WIDTH;i++)
	{
		for(int j=0;j<WIDTH;j++)
			printf("%c %f%c",j==0?'[':'\t',h_M[i*WIDTH+j], j==WIDTH-1?']':' ');

		printf("\t");

		for(int j=0;j<WIDTH;j++)
			printf("%c %f%c",j==0?'[':'\t',h_N[i*WIDTH+j], j==WIDTH-1?']':' ');

		printf("\t");

		for(int j=0;j<WIDTH;j++)
			printf("%c %f%c",j==0?'[':'\t',h_P[i*WIDTH+j], j==WIDTH-1?']':' ');
		printf("\n");
	}

	// Free
	cudaFree(d_M);
	cudaFree(d_N);
	cudaFree(d_P);
	free(h_M);
	free(h_N);
	free(h_P);

	return 0;
}
