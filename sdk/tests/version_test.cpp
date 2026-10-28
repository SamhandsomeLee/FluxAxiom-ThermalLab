#include "thermallab/version.h"

#include <gtest/gtest.h>

/// 核对版本字符串、头文件宏、构建系统版本，以及两次调用返回同一块静态内存。
///
/// **作用**：G0.2 的 unit 测试。确认动态库导出的版本、公共头宏与根 CMakeLists 的
/// `project(VERSION)` 三者一致。`EXPECTED_VERSION*` 由 `sdk/tests/CMakeLists.txt` 注入。
/// **边界**：不打开设备，不读文件。不一致时由 GoogleTest 判失败。
TEST(VersionTest, ReportsStaticG0Version) {
    const char *first = tl_get_version();
    const char *second = tl_get_version();
    ASSERT_NE(first, nullptr);
    EXPECT_EQ(first, second);
    EXPECT_STREQ(first, EXPECTED_VERSION);
    EXPECT_EQ(TL_VERSION_MAJOR, EXPECTED_VERSION_MAJOR);
    EXPECT_EQ(TL_VERSION_MINOR, EXPECTED_VERSION_MINOR);
    EXPECT_EQ(TL_VERSION_PATCH, EXPECTED_VERSION_PATCH);
}
