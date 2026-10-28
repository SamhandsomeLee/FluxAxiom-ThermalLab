# FluxAxiom ThermalLab

跨平台红外热像 SDK（C ABI）与 Qt 6/QML 客户端。计划在 Windows、Linux 和 Jetson 上回放或采集 16-bit 原始数据，并做测温、录像和推理实验。下面只写当前仓库里已经有的东西。

## 当前阶段

G0：基线与骨架（2026-10-26 至 2026-11-01），版本目标 `v0.0.1`。

当前可以构建 `thermallab` 动态库。它只导出 `tl_get_version`，返回 `0.0.1`。还不能测温、采集或推理。

本机环境：Windows，编辑器 Cursor，编译器 MSYS2 mingw64 GCC 15.2.0，生成器 Ninja。配置前把 MinGW 的 `bin` 加入 `PATH`，并设置 `VCPKG_ROOT`。仓库预设不写本机绝对路径。

```powershell
cmake --preset windows-gcc-debug
cmake --build --preset windows-gcc-debug
ctest --preset windows-gcc-debug -L "unit|golden"
```

`linux-asan` 只在 Linux 上跑，本机没有那份结果。

## 诚实边界

这是个人主导设计并完成的完整项目，不包装团队规模。一个个人项目不能据此称为“精通”，也不能当成多个完整项目的维护经验。

未实现的能力不写成已有。没有对照数据时不写性能结论，也不使用未经实测的“零拷贝”“实时”一类说法。

## 文档

- 架构：`docs/architecture/FluxAxiom ThermalLab 产品需求与系统架构设计 V2.0.md`
- 执行：`docs/development/ThermalLab 执行方案 v1.0.md`

## 许可证

MIT。全文见 `LICENSE`。
