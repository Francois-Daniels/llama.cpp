# ios.toolchain.cmake

# Tell CMake we are targeting Apple iOS
set(CMAKE_SYSTEM_NAME iOS)

# Choose platform via -DPLATFORM=OS64|SIMULATOR64|SIMULATOR_ARM64 (default OS64)
if(NOT DEFINED PLATFORM)
  set(PLATFORM "OS64")
  message(STATUS "PLATFORM not specified, defaulting to OS64 (iOS Device arm64)")
endif()

# Map platform -> sysroot name and arch
if(PLATFORM STREQUAL "OS64")
  set(CMAKE_OSX_SYSROOT "iphoneos")
  set(CMAKE_OSX_ARCHITECTURES "arm64")
elseif(PLATFORM STREQUAL "SIMULATOR_ARM64")
  set(CMAKE_OSX_SYSROOT "iphonesimulator")
  set(CMAKE_OSX_ARCHITECTURES "arm64")
else()
  message(FATAL_ERROR "Unsupported PLATFORM: ${PLATFORM} (use OS64, SIMULATOR64, SIMULATOR_ARM64)")
endif()

# Deployment target (don’t invent future versions)
if(NOT DEFINED CMAKE_OSX_DEPLOYMENT_TARGET)
  set(CMAKE_OSX_DEPLOYMENT_TARGET "18.0" CACHE STRING "Minimum iOS deployment version")
endif()

message(STATUS "Sysroot: ${CMAKE_OSX_SYSROOT}")
message(STATUS "Archs: ${CMAKE_OSX_ARCHITECTURES}")
message(STATUS "Deployment target: ${CMAKE_OSX_DEPLOYMENT_TARGET}")

# Do NOT force compilers; let CMake use AppleClang with the selected SDK
# Remove deprecated bitcode flag
# If you need extra flags, append cautiously:
#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

# Keep find root behavior sane
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

