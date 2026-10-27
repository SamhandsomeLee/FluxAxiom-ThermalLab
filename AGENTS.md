# AGENTS.md

FluxAxiom ThermalLab：跨平台红外热像 SDK（C ABI）与 Qt 6/QML 客户端，含三后端边缘推理与性能实验。

- 架构：`docs/architecture/FluxAxiom ThermalLab 产品需求与系统架构设计 V2.0.md`
- 执行：`docs/development/ThermalLab 执行方案 v1.0.md`
- 协作与边界：`.cursor/rules/`（Cursor 自动加载；其它工具请先读 `pairing.mdc`、`scope.mdc`、`boundaries.mdc`）

工作方式是结对编程：先对齐（带原文引用），再实现一刀，审查后停下，用户明确发出提交命令才提交。

模块目录下的 `AGENTS.md` 写该模块的修改范围、测试命令与禁区，优先于本文件。
