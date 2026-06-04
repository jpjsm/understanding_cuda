#include <cstdio>
#include <cuda_runtime.h>

__global__ void add1(float *x)
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    x[i] += 0.01f;
}

int main()
{
    int grid = 1;
    int block = 16;
    int size = grid * block * 2; // same as your CuPy code

    // Allocate host memory
    float *h_x = new float[size];
    for (int i = 0; i < size; i++)
    {
        h_x[i] = static_cast<float>(i);
    }

    // Allocate device memory
    float *d_x;
    cudaMalloc(&d_x, size * sizeof(float));

    // Copy host → device
    cudaMemcpy(d_x, h_x, size * sizeof(float), cudaMemcpyHostToDevice);

    // Launch kernel
    add1<<<grid, block>>>(d_x);

    // Copy device → host
    cudaMemcpy(h_x, d_x, size * sizeof(float), cudaMemcpyDeviceToHost);

    // Print results
    for (int i = 0; i < size; i++)
    {
        printf("%9.2f%s", h_x[i], (i + 1 == size ? "" : ","));
    }
    printf("\n");

    // Cleanup
    cudaFree(d_x);
    delete[] h_x;

    return 0;
}
