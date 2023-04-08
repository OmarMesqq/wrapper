cmake_minimum_required(VERSION 3.24)
project(elf_ricalc C)

set(CMAKE_C_STANDARD 11)

add_executable(RICalc main.c)

add_subdirectory (lib)
set(CMAKE_EXE_LINKER_FLAGS "-static" )
set(CMAKE_EXE_LINKER_FLAGS "-lpython3.10" )


find_library(libpython libpython3.10 PATH_SUFFIXES lib)
#target_link_libraries(RICalc LINK_PUBLIC ${libpython})


# https://cmake.org/examples/
# https://www.jetbrains.com/help/clion/quick-cmake-tutorial.html#link-libs