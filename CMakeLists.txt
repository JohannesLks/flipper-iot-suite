cmake_minimum_required(VERSION 3.13)
project(iot_suite C)

# Furi SDK wird vom Docker Container bereitgestellt
if(DEFINED ENV{FURI_SDK_PATH})
  set(FURI_SDK_PATH $ENV{FURI_SDK_PATH})
  add_subdirectory(${FURI_SDK_PATH} furi-sdk)
else()
  # Fallback für lokale Entwicklung
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(FURI REQUIRED furi)
endif()

add_executable(iot_suite
  src/main.c
)

if(DEFINED ENV{FURI_SDK_PATH})
  target_link_libraries(iot_suite furi)
  furi_create_fap(iot_suite)
else()
  target_link_libraries(iot_suite ${FURI_LIBRARIES})
  target_include_directories(iot_suite PRIVATE ${FURI_INCLUDE_DIRS})
endif()
