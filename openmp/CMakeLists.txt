cmake_minimum_required(VERSION 3.10)

# Set the project name and version
project(OpenMPExample VERSION 1.0)

# Enable OpenMP
find_package(OpenMP REQUIRED)

# Add the executable target
add_executable(OpenMPExample main.cpp)

# Link OpenMP to the target
target_link_libraries(OpenMPExample PRIVATE OpenMP::OpenMP_CXX)
