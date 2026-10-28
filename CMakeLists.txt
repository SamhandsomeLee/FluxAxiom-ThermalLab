cmake_minimum_required(VERSION 3.28)

# G0.2 骨架：动态库、版本函数和测试。不安装，不交叉编译。
project(thermallab VERSION 0.0.1 LANGUAGES C CXX)

include(CTest)

# 由 linux-asan 预设打开。其它预设保持关闭。
option(THERMALLAB_ENABLE_SANITIZERS "Build with ASan, UBSan and LSan" OFF)
if(THERMALLAB_ENABLE_SANITIZERS AND NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
  message(FATAL_ERROR "THERMALLAB_ENABLE_SANITIZERS is supported only on Linux.")
endif()

include(cmake/CompilerWarnings.cmake)
include(cmake/Sanitizers.cmake)

add_subdirectory(sdk)
