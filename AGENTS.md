# AGENTS.md

FluxAxiom ThermalLab：跨平台红外热像 SDK（C ABI）与 Qt 6/QML 客户端规划，含后续推理与性能实验；现有实现以当前分支源码为准。

- 架构：`docs/architecture/FluxAxiom ThermalLab 产品需求与系统架构设计 V2.0.md`
- 执行：`docs/development/ThermalLab 执行方案 v1.0.md`
- 验收现状：`docs/development/G0 验收报告.md`
- Cursor 协作入口：`.cursor/README.md`、`.cursor/rules/mentor-mode.mdc`、`.cursor/rules/response-clarity.mdc`
- 技术边界与 Git：`.cursor/rules/scope.mdc`、`.cursor/rules/boundaries.mdc`、`.cursor/rules/git.mdc`

**协作方式是人类主导的导师模式，不是结对代写**：先查真实源码和约束，解释架构与原理，给逐级提示和测试方案；由用户做架构决策并亲手实现关键逻辑。默认只读，明确授权才能改指定文件；独立审查不自动修复；只有明确 commit/push 指令才执行 Git 操作。

模块目录下的 `AGENTS.md` 描述该模块的局部修改范围、测试命令与禁区；遵循它们时仍须保留全局授权和安全边界。
