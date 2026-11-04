# ThermalLab 源码导航（当前 main 的核对入口，不代表永久事实）

先检查分支与文件存在性。当前仓库 G0 SDK 只有版本导出，不是完整红外产品。

| 能力 | 起始文件 | 继续核对 |
| --- | --- | --- |
| 工作区与构建 | `CMakeLists.txt`、`CMakePresets.json` | `sdk/CMakeLists.txt`、`sdk/core/CMakeLists.txt` |
| 公开 C ABI | `sdk/include/thermallab/version.h`、`export.h` | `sdk/core/version.cpp`、`sdk/tests/c99_header_test.c` |
| 现有 SDK 单测 | `sdk/tests/version_test.cpp` | `sdk/tests/CMakeLists.txt` |
| 构建/格式/许可证门禁 | `.github/workflows/ci.yml` | `scripts/check_license_allowlist.py` |
| 决策和阶段 | `docs/adr/ADR-001-cpp-rust.md`、`ADR-002-device-owner.md`、`ADR-004-sdk-abi.md` | `docs/development/G0 验收报告.md` |
| 后续 Y16 回放/ROI/Qt/服务 | `docs/development/ThermalLab 执行方案 v1.0.md` | 目前属计划，先检查对应源码是否存在 |

推荐追踪顺序：使用者→入口→实现→数据所有权→错误路径→测试→构建/CI 证据。
