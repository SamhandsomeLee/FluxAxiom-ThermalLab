/**
 * 用 C99 编译并调用全部公共头。
 *
 * **作用**：拦住混进公共头的 C++ 类型、命名空间和 `bool`，并确认纯 C 程序能链接动态库。
 * **边界**：只调用 `tl_get_version`。版本指针为 NULL，或字符串、宏与构建系统注入的
 * `EXPECTED_VERSION*`（来自根 CMakeLists 的 `project(VERSION)`）不一致时返回 1。
 */
#include "thermallab/export.h"
#include "thermallab/version.h"

#include <string.h>

int main(void) {
    const char *version = tl_get_version();
    if (version == 0) {
        return 1;
    }
    if (strcmp(version, EXPECTED_VERSION) != 0) {
        return 1;
    }
    if (TL_VERSION_MAJOR != EXPECTED_VERSION_MAJOR || TL_VERSION_MINOR != EXPECTED_VERSION_MINOR ||
        TL_VERSION_PATCH != EXPECTED_VERSION_PATCH) {
        return 1;
    }
    return 0;
}
