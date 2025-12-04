# Use NVIDIA CUDA container as the base image
FROM nvcr.io/nvidia/nvhpc:25.7-devel-cuda_multi-ubuntu22.04

ENV HDFPATH=/home/cernetic/sw/hdf5/intallNvidiaopenmpi
ENV LD_LIBRARY_PATH=$HDFPATH/lib:$LD_LIBRARY_PATH


# Copy CMake options file
COPY HDF5options.cmake /HDF5options.cmake

# Install zlib, cmake, ninja and other necessary packages, create directories, and download HDF5
RUN apt-get update && \
  apt-get install -y zlib1g-dev wget cmake ninja-build && \
  wget -q https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.6/hdf5-1.14.6.tar.gz && \
  tar -xzf hdf5-1.14.6.tar.gz && \
  cd hdf5-1.14.6 && \
  mkdir build && \
  cd build && \
  cmake -GNinja -C /HDF5options.cmake .. && \
  ninja && \
  ninja install && \
  cd ../.. && \
  rm -rf hdf5-1.14.6* && \
  rm -rf /var/lib/apt/lists/*
