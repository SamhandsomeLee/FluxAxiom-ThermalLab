#ifndef THERMALLAB_VERSION_H
#define THERMALLAB_VERSION_H

#include "thermallab/export.h"

/** 语义化版本的主版本号。G0 为 0。 */
#define TL_VERSION_MAJOR 0
/** 语义化版本的次版本号。G0 为 0。 */
#define TL_VERSION_MINOR 0
/** 语义化版本的补丁号。G0 骨架为 1，对应 v0.0.1。 */
#define TL_VERSION_PATCH 1

#ifdef __cplusplus
extern "C" {
#endif

/**
 * 返回 SDK 版本字符串。
 *
 * **作用**：让测试和后续示例确认链接到的是哪一版 `thermallab`。
 * **所有权**：borrow。指针指向库内静态字符串，有效期到进程结束，调用方不要释放。
 * **线程**：任意线程都可以调用。没有共享可变状态。
 * **边界**：内容固定为 `0.0.1`，不返回 NULL。这一阶段没有 `tl_status`，函数不失败。
 * 不做测温、采集或回放。
 */
TL_API const char *tl_get_version(void);

#ifdef __cplusplus
}
#endif

#endif /* THERMALLAB_VERSION_H */
