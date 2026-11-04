# ThermalLab · Human-Led Development System

本目录参考 FluxAxiom 的 `exp/ea-ctx` 分支教学配置，适配 ThermalLab 的 C++17 / C ABI、CMake、Qt/QML、红外 SDK 与跨平台实验。

**原则：人主导架构决策与关键实现，Cursor 做导师、源码导航、分级提示、测试设计与独立审查。** 不因教学模式降低工程安全和验收标准。

## 文件职责

- `rules/mentor-mode.mdc`：默认只读、授权边界与 L1–L4 提示协议（Always）。
- `rules/response-clarity.mdc`：结论先行、整体到局部、降低认知负担（Always）。
- `rules/pairing.mdc`：保留原路径以兼容既有引用，但内容改为人主导开发引导（Intelligent）。
- `rules/scope.mdc`、`boundaries.mdc`、`git.mdc`：阶段、安全和提交约束继续生效。
- 其他按文件触发的规则：C ABI、Qt、构建 CI、契约与许可证。
- `rules/review-sweep.mdc`：只在明确审查时按需读取，不全局注入。
- `skills/`：七个显式调用的教学流程；不额外创建重复的 commands。

规则是提示词，不是操作系统沙箱。真正的写权限还由 Cursor 模式、工具权限及用户授权决定。

## 常用入口

| 任务 | Skill |
| --- | --- |
| 带读源码、理解真实数据流 | `/tl-codebase-tour` |
| 拆解模块、比较设计方案 | `/tl-architecture-coach` |
| C++17、RAII、所有权、C ABI、CMake、Qt 原理 | `/tl-cpp-mentor` |
| 编译失败、崩溃、线程与硬件故障分析 | `/tl-debug-coach` |
| 设计 unit / golden / contract / hardware 验收 | `/tl-test-coach` |
| 对人类写的 diff 做独立审查 | `/tl-code-review` |
| 复盘架构、语言机制与迁移能力 | `/tl-learning-review` |

## 典型闭环

1. `/tl-codebase-tour`：先找真实入口、数据流、状态所有者和现有测试。
2. `/tl-architecture-coach`：明确边界、契约、不变量、非目标和验收，用户负责决策。
3. 用户亲手实现关键生产逻辑；疑问用 `/tl-cpp-mentor` 或 `/tl-debug-coach`，Cursor 可在明确授权后辅助机械性编辑。
4. `/tl-test-coach`：从最小失败用例开始，设计正常、边界与故障场景。
5. `/tl-code-review`：只读检查 diff，提出问题与验证证据，不自动修复。
6. `/tl-learning-review`：把本次理解迁移到另一个类似问题。

较小的任务可缩短流程，但不能绕过授权、边界或必要验证。

## 提示级别

- **L1（默认）**：先讲原理、职责与不变量，不给成套生产代码。
- **L2**：指出真实文件、调用路径、关键表达式与错误机制。
- **L3**：提供最小独立示例、接口签名、伪代码或测试骨架。
- **L4**：仅在用户明确要求时给完整参考实现。给示例不等于允许写文件。

用户说“继续”时，深入下一个函数/逻辑单元；用户要完整架构或直接答案时不要机械分轮。

## 证据与阶段

- **当前事实**：以 checkout 分支中的源码、测试和实际命令输出为准。
- **长期约束**：已采用 ADR、冻结契约；ADR-004 当前仍是草案，不能冒充已冻结。
- **执行范围**：`docs/development/ThermalLab 执行方案 v1.0.md`、`docs/development/G0 验收报告.md` 和 `rules/scope.mdc`。截至当前仓库 G0 仍在补证，G0.4/G0.5 与 Linux 环境采集 Blocked；不能因日期进入 G1 就越过未完成的非 Blocked 工作。
- **未来计划**：Qt 桌面、温度换算、Jetson 推理、ThermalService 等在当前 main 尚未实现，不把设计当代码。

阅读导航参见 `skills/tl-codebase-tour/references/architecture-map.md`。

## 手工验收（在 Cursor 内）

1. 提问“解释 tl_get_version 的调用链”，应先给小范围真实架构与一个阅读入口；不修改文件。
2. 说“看不懂，继续”，应逐步聚焦下一个逻辑，避免一次输出整套系统。
3. 要求完整 C++ 参考代码，应可在聊天里得到，但未授权写入时工作区不变。
4. 仅请求“审查 diff”，应得到风险、证据与测试建议，而非自动修复。
5. 只允许修改指定文件时，实际 diff 不得扩展；“认可”不触发 commit 或 push。
6. 在 Cursor 输入 `/tl-`，核实七个 Skill 均在当前版本的 Slash 菜单出现。

这次只是配置更新；没有业务源码修改，不以此声称 Windows/Linux/Jetson 编译或测试已通过。
