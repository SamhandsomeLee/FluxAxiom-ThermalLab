find_package(GTest CONFIG REQUIRED)

add_executable(thermallab_version_test version_test.cpp)
target_link_libraries(thermallab_version_test PRIVATE thermallab::core
                                                      GTest::gtest_main)
target_compile_features(thermallab_version_test PRIVATE cxx_std_17)
set_target_properties(thermallab_version_test PROPERTIES CXX_STANDARD 17
                                                         CXX_STANDARD_REQUIRED ON
                                                         CXX_EXTENSIONS OFF)
thermallab_set_warnings(thermallab_version_test)
thermallab_enable_sanitizers(thermallab_version_test)

add_executable(thermallab_c99_header_test c99_header_test.c)
target_link_libraries(thermallab_c99_header_test PRIVATE thermallab::core)
set_target_properties(
  thermallab_c99_header_test
  PROPERTIES LINKER_LANGUAGE C
             C_STANDARD 99
             C_STANDARD_REQUIRED ON
             C_EXTENSIONS OFF)
thermallab_set_warnings(thermallab_c99_header_test)
thermallab_enable_sanitizers(thermallab_c99_header_test)

# 期望版本取自根 CMakeLists 的 project(VERSION)，让头文件宏、库返回值和构建系统互相校验。
foreach(test_target thermallab_version_test thermallab_c99_header_test)
  target_compile_definitions(
    ${test_target}
    PRIVATE EXPECTED_VERSION="${PROJECT_VERSION}"
            EXPECTED_VERSION_MAJOR=${PROJECT_VERSION_MAJOR}
            EXPECTED_VERSION_MINOR=${PROJECT_VERSION_MINOR}
            EXPECTED_VERSION_PATCH=${PROJECT_VERSION_PATCH})
endforeach()

set_target_properties(
  thermallab_version_test thermallab_c99_header_test
  PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
             BUILD_RPATH "\$ORIGIN")

include(GoogleTest)
gtest_discover_tests(
  thermallab_version_test
  PROPERTIES
  LABELS
  unit
  DISCOVERY_MODE
  PRE_TEST)

add_test(NAME thermallab_c99_header_test COMMAND thermallab_c99_header_test)
set_tests_properties(thermallab_c99_header_test PROPERTIES LABELS unit)
