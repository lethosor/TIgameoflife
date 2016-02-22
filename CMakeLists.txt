cmake_minimum_required(VERSION 2.8)

project(tigol)
set(CMAKE_BUILD_TYPE Release)

if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "In-source build detected")
endif()

if(NOT CMAKE_CROSSCOMPILING)
    message(FATAL_ERROR "Native compiler detected")
endif()

set(CMAKE_MODULE_PATH
    "${CMAKE_SOURCE_DIR}/CMake/Modules"
    "${CMAKE_MODULE_PATH}"
)
enable_language(ASM-Z80)

set(CMAKE_C_FLAGS "-mz80 --std-sdcc99 --reserve-regs-iy --max-allocs-per-node 30000")
set(CMAKE_ASM_FLAGS "-p -g")
set(CMAKE_EXE_LINKER_FLAGS "--code-loc 0x9D9B --data-loc 0 --no-std-crt0")

find_package(PythonInterp REQUIRED)
find_program(HEX2BIN hex2bin hex2bin.exe)
if("${HEX2BIN}" STREQUAL "HEX2BIN-NOTFOUND")
    message(FATAL_ERROR "Could not locate hex2bin")
endif()

add_executable(tigol
    tigol.c
    inc/ti84plus.c
    inc/tios_crt0.s
    inc/fastcopy.asm
)

add_custom_command(TARGET tigol POST_BUILD
    COMMAND ${HEX2BIN} tigol.ihx
    COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/depends/binpac8x.py -O conway tigol.bin tigol.8xp
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Converting to binary"
)

set(TIGOL_GENERATED_FILES
    ${CMAKE_BINARY_DIR}/tigol.8xp
    ${CMAKE_BINARY_DIR}/tigol.bin
    ${CMAKE_BINARY_DIR}/tigol.lk
    ${CMAKE_BINARY_DIR}/tigol.map
    ${CMAKE_BINARY_DIR}/tigol.noi
)

set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${TIGOL_GENERATED_FILES}")
