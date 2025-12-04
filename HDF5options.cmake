####################################################################
# HDF5 CMake Build Configuration Options
# Equivalent to autotools: --enable-fortran --enable-shared --with-pic
####################################################################

# Install prefix
set(CMAKE_INSTALL_PREFIX "/home/cernetic/sw/hdf5/intallNvidiaopenmpi/" CACHE PATH "Install path prefix")

# Enable Fortran support (equivalent to --enable-fortran)
set(HDF5_BUILD_FORTRAN ON CACHE BOOL "Build FORTRAN support")

# Enable shared libraries (equivalent to --enable-shared)
set(BUILD_SHARED_LIBS ON CACHE BOOL "Build Shared Libraries")

# Enable Position Independent Code (equivalent to --with-pic)
set(CMAKE_POSITION_INDEPENDENT_CODE ON CACHE BOOL "Build with position independent code")

# MPI compiler settings for parallel HDF5
set(CMAKE_C_COMPILER "mpicc" CACHE STRING "C compiler")
set(CMAKE_Fortran_COMPILER "mpif90" CACHE STRING "Fortran compiler") 
set(CMAKE_CXX_COMPILER "mpicxx" CACHE STRING "C++ compiler")

# Optimization flags matching original autotools build
set(CMAKE_C_FLAGS "-fPIC -O3" CACHE STRING "C compiler flags")
set(CMAKE_Fortran_FLAGS "-fPIC -O3" CACHE STRING "Fortran compiler flags")
set(CMAKE_CXX_FLAGS "-fPIC -O3" CACHE STRING "C++ compiler flags")

# Enable compression support (default in original build)
set(HDF5_ENABLE_Z_LIB_SUPPORT ON CACHE BOOL "Enable Zlib Filters")
set(HDF5_ENABLE_SZIP_SUPPORT ON CACHE BOOL "Use SZip Filter")

# Build configuration
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type")

# Parallel build support (equivalent to --enable-parallel)
set(HDF5_ENABLE_PARALLEL ON CACHE BOOL "Enable parallel build (requires MPI)")

# Testing and examples (can be disabled for faster builds)
set(BUILD_TESTING OFF CACHE BOOL "Build HDF5 Unit Testing")
set(HDF5_BUILD_EXAMPLES OFF CACHE BOOL "Build HDF5 Library Examples")
set(HDF5_BUILD_TOOLS ON CACHE BOOL "Build HDF5 Tools")