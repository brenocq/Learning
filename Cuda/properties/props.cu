// nvcc props.cu -o a && ./a
#include <stdio.h>

int main()
{
	int devCount;
	cudaGetDeviceCount(&devCount);
	printf("Found %d devices with CUDA support.\n", devCount);

	for(int i=0; i<devCount; i++)
	{
		cudaDeviceProp devProp;
		cudaGetDeviceProperties(&devProp, i);
		printf("- DEVICE %d:\n",i);
		printf("  - Name: %s\n", devProp.name);
		printf("  - Max threads per block: %d\n", devProp.maxThreadsPerBlock);
		printf("  - Max blocks per SM: %d\n", devProp.maxBlocksPerMultiProcessor);
		printf("  - Qty SMs: %d\n", devProp.multiProcessorCount);
		printf("  - Clock: %d MHz\n", devProp.clockRate/1000);
		printf("  - Max thread dim: dim3(%d, %d, %d)\n", devProp.maxThreadsDim[0], devProp.maxThreadsDim[1], devProp.maxThreadsDim[2]);
		printf("  - Warp size: %d\n", devProp.warpSize);
		printf("  - Regs/block: %d\n", devProp.regsPerBlock);
		printf("  - Regs/SM: %d\n", devProp.regsPerMultiprocessor);
		printf("  - Shared mem/Block: %d KB\n", devProp.sharedMemPerBlock/1024);
		printf("  - Shared mem/SM: %d KB\n", devProp.sharedMemPerMultiprocessor/1024);
		printf("  - Constant mem: %d KB\n", devProp.totalConstMem/1024);
		printf("  - Cache L2: %d MB\n", devProp.l2CacheSize/(1024*1024));
	}

	return 0;
}
