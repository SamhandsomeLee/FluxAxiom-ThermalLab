# ADR-004：SDK ABI、所有权与版本

- 状态：草案
- 日期：2026-11-02
- 依据：执行方案 v1.0 §4.2.1、§8.2；设计文档 V2.0 §5.2

本文件是 G0.8 的起草。定稿留到 G1.5。这里不发布错误码数值，也不实现 G1 的函数。

## 背景

集成方要用 C、以后还可能用别的语言调用测温。如果公共头文件露出 C++ 标准库、异常或编译器相关布局，换一个编译器就会打不开。G0 已经导出 `tl_get_version`。其余函数还没写，边界要先写下来，避免 G1 各自发明一套。

## 决定

- 公共头文件只放在 `sdk/include/thermallab/`，以 `extern "C"` 导出，前缀为 `tl_` / `TL_`。
- 公共类型只用固定宽度整数、`float`、`double`、指针和 UTF-8 `const char*`。结构体字段不用 C `enum`，用 `int32_t` 保存枚举值。
- 不在公共 API 中暴露 `std::string`、STL 容器、C++ 异常或 Qt 类型。异常留在 C++ 内部，跨过边界时变成错误码。
- 可扩展结构体的前两个字段是 `uint32_t size` 和 `uint32_t version`。新字段只加在末尾。
- 句柄不透明。`create` 与 `destroy` 成对。`destroy(NULL)` 安全。
- 帧数据的所有权每次在拷贝、借用、引用计数里选一种，并写明指针有效到哪一次调用。
- 设计文档 §5.2 列出的最小函数集留到 G1 冻结：`tl_get_version`、`tl_create`、`tl_open_source`、`tl_next_frame`、`tl_release_frame`、`tl_get_temperature_map`、`tl_measure_roi`、`tl_destroy`、`tl_last_error_message`。
- G0 只实现 `tl_get_version`。它返回库内静态字符串 `0.0.1`，调用方不释放，有效到进程结束。这一阶段没有 `tl_status`。
- 错误码发布之后不改数值、不复用。`TL_OK == 0` 是目标约定。具体错误码的值和名字表在 G1.2 写，本草案不指定。
- Windows 用 MSYS2 MinGW GCC 构建。这不证明 MSVC 程序能链接同一份库。Linux 用 GCC。Jetson 的 aarch64 构建仍是 `Blocked`，不在本草案里宣称已经链接通过。

## 备选与取舍

| 方案 | 代价 | 不采用的原因 |
| --- | --- | --- |
| 直接导出 C++ 类 | 头文件简单 | 布局和异常跟编译器绑定，C 调用方用不了 |
| 现在就定稿全部错误码和函数 | G1 不能再改签名 | 执行方案把定稿放在 G1.5，G0 还没有那些类型 |
| 先写原则和现有的 `tl_get_version`，G1.5 定稿 | G1 之前调用方不能依赖未实现的函数 | 采用 |

## 证据

`sdk/include/thermallab/version.h` 中的 `tl_get_version` 与执行方案 §4.2.1 的 G0.2 记录一致：返回静态 `0.0.1`，没有 `tl_status`。C99 头文件编译测试已在 G0.2 加入。没有 MSVC 链接实验。Jetson 链接待 G0.4 解冻后实测。

## 后果

- G1.2 之前不在公共头文件里增加错误码枚举或数值。
- G1.5 定稿时要核对最小函数集是否仍是 §5.2 那九个，并补上每个函数的所有权和线程说明。
- 若要证明 MSVC 能链接，单独做一次实验，不把 MinGW 的通过当成那个证明。
- 插件 ABI 不在本草案里冻结，留到 ADR-008。
