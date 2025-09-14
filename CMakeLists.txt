cmake_minimum_required(VERSION 3.13)
project(hello_fap C)

if(DEFINED ENV{FURI_SDK_PATH})
  set(FURI_SDK_PATH $ENV{FURI_SDK_PATH})
else()
  if(EXISTS "${CMAKE_SOURCE_DIR}/furi-sdk/CMakeLists.txt")
    set(FURI_SDK_PATH "${CMAKE_SOURCE_DIR}/furi-sdk")
  else()
    message(FATAL_ERROR "FURI_SDK_PATH nicht gesetzt und ./furi-sdk nicht gefunden.")
  endif()
endif()

add_subdirectory(${FURI_SDK_PATH} furi-sdk)

add_executable(hello_fap
  src/main.c
)

target_link_libraries(hello_fap furi)
furi_create_fap(hello_fap)
