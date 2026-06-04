cmake_minimum_required(VERSION 3.27)

project(MSVC_CUDA_Project LANGUAGES CXX CUDA)

# -------------------------------
# Global C++ settings
# -------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# -------------------------------
# Global CUDA settings
# -------------------------------
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Allow separate compilation of CUDA files
set(CMAKE_CUDA_SEPARABLE_COMPILATION ON)

# -------------------------------
# C++ Executable
# -------------------------------
add_executable(app_cpp src/main.cpp)

# -------------------------------
# CUDA Executable
# -------------------------------
add_executable(app_cuda src/main.cu)

# Ensure MSVC is used as host compiler for CUDA
set_target_properties(app_cuda PROPERTIES
    CUDA_ARCHITECTURES "native"
    CUDA_HOST_COMPILER "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64/cl.exe"
)
