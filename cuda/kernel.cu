#include <iostream>
#include <cuda_runtime.h>

// CUDA kernel to add two arrays
__global__ void add_arrays(int *a, int *b, int *c, int size) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    // printf("%d", index);
    if (index < size) {
        // printf("%d", index);
        c[index] = a[index] + b[index];
    }
}

int main() {
    const int array_size = 100;
    const int array_bytes = array_size * sizeof(int);

    // Allocate memory on the host (CPU)
    int *h_a = new int[array_size];
    int *h_b = new int[array_size];
    int *h_c = new int[array_size];

    // Initialize arrays on the host
    for (int i = 0; i < array_size; i++) {
        h_a[i] = i;
        h_b[i] = i * 2;
    }

    // Allocate memory on the device (GPU)
    int *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, array_bytes);
    cudaMalloc(&d_b, array_bytes);
    cudaMalloc(&d_c, array_bytes);

    // Copy data from host to device
    cudaMemcpy(d_a, h_a, array_bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, array_bytes, cudaMemcpyHostToDevice);

    // Launch the CUDA kernel with 10 blocks of 10 threads each
    add_arrays<<<(array_size + 9) / 10, 10>>>(d_a, d_b, d_c, array_size);

    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
    }

    // Copy the result back from device to host
    cudaMemcpy(h_c, d_c, array_bytes, cudaMemcpyDeviceToHost);

    // Output the result
    for (int i = 0; i < 10; i++) {  // Show the first 10 results
        std::cout << h_c[i] << " ";
    }
    std::cout << std::endl;

    // Free device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    // Free host memory
    delete[] h_a;
    delete[] h_b;
    delete[] h_c;

    return 0;
}
