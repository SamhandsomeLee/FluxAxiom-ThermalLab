add_library(thermallab_core SHARED version.cpp)
add_library(thermallab::core ALIAS thermallab_core)

target_include_directories(
  thermallab_core PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/sdk/include>)
target_compile_features(thermallab_core PUBLIC cxx_std_17)
set_target_properties(thermallab_core PROPERTIES CXX_STANDARD 17
                                                 CXX_STANDARD_REQUIRED ON
                                                 CXX_EXTENSIONS OFF)
target_compile_definitions(thermallab_core PRIVATE THERMALLAB_CORE_BUILD)
thermallab_set_warnings(thermallab_core)
thermallab_enable_sanitizers(thermallab_core)

set_target_properties(
  thermallab_core
  PROPERTIES OUTPUT_NAME thermallab
             VERSION ${PROJECT_VERSION}
             SOVERSION ${PROJECT_VERSION_MAJOR}
             C_VISIBILITY_PRESET hidden
             CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN ON
             RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
             LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
             ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# MinGW 默认给 DLL 加 lib 前缀。Windows 上的文件名保持 thermallab.dll。
if(WIN32)
  set_target_properties(thermallab_core PROPERTIES PREFIX "" IMPORT_PREFIX "")
endif()
