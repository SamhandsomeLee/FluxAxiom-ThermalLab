#ifndef THERMALLAB_EXPORT_H
#define THERMALLAB_EXPORT_H

/**
 * 动态库导出宏。
 *
 * **作用**：标注 `thermallab` 动态库对调用方可见的 C 函数。库自己的编译定义
 * `THERMALLAB_CORE_BUILD`；调用方不要定义它。
 * **边界**：只用于 C ABI。这一阶段没有 C++ 导出。
 */
#if defined(_WIN32)
#if defined(THERMALLAB_CORE_BUILD)
#define TL_API __declspec(dllexport)
#else
#define TL_API __declspec(dllimport)
#endif
#else
#if defined(THERMALLAB_CORE_BUILD)
#define TL_API __attribute__((visibility("default")))
#else
#define TL_API
#endif
#endif

#endif /* THERMALLAB_EXPORT_H */
