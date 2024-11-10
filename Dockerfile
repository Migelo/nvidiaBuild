# Use NVIDIA CUDA container as the base image
FROM nvcr.io/nvidia/nvhpc:24.1-devel-cuda_multi-ubuntu22.04

ENV HDFPATH=/home/cernetic/sw/hdf5/intallNvidiaopenmpi
ENV LD_LIBRARY_PATH=$HDFPATH/lib:$LD_LIBRARY_PATH


# Install zlib and other necessary packages, create directories, and download HDF5
RUN apt-get update && \
  apt-get install -y zlib1g-dev wget && \
  wget -q https://github.com/HDFGroup/hdf5/releases/download/hdf5_1.14.4.3/hdf5-1.14.4-3.tar.gz && \
  tar -xzf hdf5-1.14.4-3.tar.gz && \
  cd hdf5-1.14.4-3 && \
  ./configure \
  --prefix=$HDFPATH \
  --enable-fortran \
  --enable-shared \
  --enable-parallel \
  --with-pic \
  CC=mpicc \
  FC=mpif90 \
  CXX=mpicxx \
  CFLAGS="-fPIC -O3" \
  FFLAGS="-fPIC -O3" \
  CXXFLAGS="-fPIC -O3" && \
  make -j && \
  make install && \
  cd .. && \
  rm -rf hdf5-1.14.4-3* && \
  rm -rf /var/lib/apt/lists/*
