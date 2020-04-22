#include <stdio.h>
#include <stdlib.h>

#define SIZE 1024

__global__ void vectorAdd(int *a, int *b, int *c, int n)
{
	int i = threadIdx.x;

	if(i<n)
		c[i]=a[i]+b[i];
}

int main()
{
	int *a, *b, *c;

	int id = cudaGetDevice(&id);
	printf("GPU id: %d\n",id);

	cudaMallocManaged(&a, SIZE*sizeof(int));
	cudaMallocManaged(&b, SIZE*sizeof(int));
	cudaMallocManaged(&c, SIZE*sizeof(int));

	for(int i=0;i<SIZE;i++)
	{
		a[i]=i;
		b[i]=i;
		c[i]=0;
	}

	// Start sending data to gpu
	cudaMemPrefetchAsync(a, SIZE, id);
	cudaMemPrefetchAsync(b, SIZE, id);
	vectorAdd<<<1, SIZE>>>(a,b,c, SIZE);
	cudaDeviceSynchronize();
	
	// Send data back to cpu
	cudaMemPrefetchAsync(c, SIZE, cudaCpuDeviceId);

	for(int i=0;i<10;i++)
		printf("c[%d]=%d\n",i,c[i]);

	cudaFree(a);
	cudaFree(b);
	cudaFree(c);

	return 0;
}
