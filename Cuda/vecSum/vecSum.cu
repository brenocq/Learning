// nvcc vecSum.cu -o a && ./a
#include <stdio.h>
#include <stdlib.h>

#define SIZE 50

__global__ void vectorAddKernel(float* a, float* b, float* c, int n)
{
	int i = blockDim.x*blockIdx.x + threadIdx.x;

	if(i<n) c[i]=a[i]+b[i];
}

int main()
{
	float *d_a, *d_b, *d_c;
	float *h_a, *h_b, *h_c;

	int id = cudaGetDevice(&id);
	printf("GPU id: %d\n",id);

	// Alloc memory CPU
	h_a = (float*)malloc(SIZE*sizeof(float));
	h_b = (float*)malloc(SIZE*sizeof(float));
	h_c = (float*)malloc(SIZE*sizeof(float));

	// Alloc memory GPU
	cudaMalloc((void**)&d_a, SIZE*sizeof(float));
	cudaMalloc((void**)&d_b, SIZE*sizeof(float));
	cudaMalloc((void**)&d_c, SIZE*sizeof(float));

	// Initialize vectors
	for(int i=0;i<SIZE;i++)
	{
		h_a[i]=i;
		h_b[i]=i;
		h_c[i]=0;
	}

	// Copy from CPU to GPU
	cudaMemcpy(d_a, h_a, SIZE*sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, h_b, SIZE*sizeof(float), cudaMemcpyHostToDevice);

	vectorAddKernel<<<ceil(SIZE/256.0), 256>>>(d_a,d_b,d_c, SIZE);
	
	// Copy from GPU to CPU
	cudaMemcpy(h_c, d_c, SIZE*sizeof(float), cudaMemcpyDeviceToHost);

	// Print
	for(int i=0;i<SIZE;i++)
		printf("c[%d]=%f\n",i,h_c[i]);

	// Free
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	free(h_a);
	free(h_b);
	free(h_c);

	return 0;
}
