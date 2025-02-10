cmake_minimum_required(VERSION 3.10)
project(OpenCV_Rainbow)

find_package(OpenCV REQUIRED)

add_executable(rainbow main.cpp)

target_link_libraries(rainbow ${OpenCV_LIBS})
