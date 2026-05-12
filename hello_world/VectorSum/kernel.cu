#include <iostream>
#define N 512

__global__ void add(int* a, int* b, int* c) {
    int index = threadIdx.x;
    c[index] = a[index] + b[index];
}

int main() {
    int a[N], b[N], c[N];
    int* d_a, * d_b, * d_c;

    // Reservar memoria en GPU
    cudaMalloc((void**)&d_a, N * sizeof(int));
    cudaMalloc((void**)&d_b, N * sizeof(int));
    cudaMalloc((void**)&d_c, N * sizeof(int));

    // Inicializar datos
    for (int i = 0; i < N; i++) {
        a[i] = i;
        b[i] = i * 2;
    }

    // Copiar datos a GPU
    cudaMemcpy(d_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, N * sizeof(int), cudaMemcpyHostToDevice);

    // Ejecutar kernel
    add << <1, N >> > (d_a, d_b, d_c);

    // Copiar resultado a CPU
    cudaMemcpy(c, d_c, N * sizeof(int), cudaMemcpyDeviceToHost);

    // Mostrar resultados
    for (int i = 0; i < N; i++) {
        std::cout << a[i] << " + " << b[i] << " = " << c[i] << std::endl;
    }

    // Liberar memoria
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    return 0;
}