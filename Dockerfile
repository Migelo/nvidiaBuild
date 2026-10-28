# Use NVIDIA CUDA container as the base image
FROM nvcr.io/nvidia/nvhpc:26.9-devel-cuda_multi-ubuntu22.04

ARG HDF5_VERSION=2.2.0
ARG CMAKE_VERSION=3.31.10

ENV HDFPATH=/home/cernetic/sw/hdf5/intallNvidiaopenmpi
ENV LD_LIBRARY_PATH=${HDFPATH}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# Copy CMake options file
COPY HDF5options.cmake /HDF5options.cmake

# Install HDF5 dependencies, a recent CMake, and download/build HDF5
RUN apt-get update && \
  apt-get install -y zlib1g-dev libaec-dev wget python3-pip ninja-build && \
  pip3 install --no-cache-dir "cmake==${CMAKE_VERSION}" && \
  case "${HDF5_VERSION}" in \
    1.*) HDF5_RELEASE_TAG="hdf5_${HDF5_VERSION}" ;; \
    *) HDF5_RELEASE_TAG="${HDF5_VERSION}" ;; \
  esac && \
  wget -q \
    "https://github.com/HDFGroup/hdf5/releases/download/${HDF5_RELEASE_TAG}/hdf5-${HDF5_VERSION}.tar.gz" \
    "https://github.com/HDFGroup/hdf5/releases/download/${HDF5_RELEASE_TAG}/hdf5-${HDF5_VERSION}.sha256sums.txt" && \
  grep " hdf5-${HDF5_VERSION}.tar.gz$" "hdf5-${HDF5_VERSION}.sha256sums.txt" | sha256sum -c - && \
  tar -xzf "hdf5-${HDF5_VERSION}.tar.gz" && \
  cd "hdf5-${HDF5_VERSION}" && \
  mkdir build && \
  cd build && \
  cmake -GNinja -C /HDF5options.cmake .. && \
  ninja && \
  ninja install && \
  cd ../.. && \
  rm -rf "hdf5-${HDF5_VERSION}"* && \
  rm -rf /var/lib/apt/lists/*
