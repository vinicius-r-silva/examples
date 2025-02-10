cmake_minimum_required(VERSION 3.27)
project(CudaExample LANGUAGES CXX CUDA)

# Set CUDA flags (optional, can be adjusted)
set(CMAKE_CUDA_STANDARD 17)

# Add executable with CUDA source files
add_executable(cuda_example kernel.cu)

# CMake will automatically link CUDA libraries, so no need to manually link