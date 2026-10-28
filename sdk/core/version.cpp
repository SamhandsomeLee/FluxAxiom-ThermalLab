#include "thermallab/version.h"

#define TL_STRINGIFY_IMPL(text) #text
#define TL_STRINGIFY(text) TL_STRINGIFY_IMPL(text)

namespace tl {

/// 与头文件里的三个版本宏是同一组数字，避免字符串和宏各写一遍。
constexpr char kVersion[] = TL_STRINGIFY(TL_VERSION_MAJOR) "." TL_STRINGIFY(
    TL_VERSION_MINOR) "." TL_STRINGIFY(TL_VERSION_PATCH);

} // namespace tl

#undef TL_STRINGIFY
#undef TL_STRINGIFY_IMPL

/// 返回 SDK 版本字符串。
///
/// **作用**：`thermallab` 动态库里 `tl_get_version` 的实现。
/// **边界**：返回 `kVersion`。该数组在进程内一直存在，函数不分配内存，也不失败。
/// 这一阶段没有错误码，函数体不抛异常。
const char *tl_get_version(void) { return tl::kVersion; }
