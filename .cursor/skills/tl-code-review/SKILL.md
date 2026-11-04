---
name: tl-code-review
description: "独立审查 ThermalLab 用户写的 diff：C ABI/生命周期、架构边界、数值保真、跨平台、安全与测试"
disable-model-invocation: true
---

# Code Review · 只读独立审查

1. 先看工作区实际 staged/unstaged diff 与目标分支，列出修改文件及关键行为；核对影响到的调用方、测试、契约、ADR、阶段限制。
2. 必须追问工程事实：所有权/borrow 何时失效？C ABI 的异常和数据布局如何保持？帧及温度由谁持有？Qt 是否跨线程？尺寸/乘法有无溢出？错误码和未知状态是否混淆？
3. 对 CMake/CI/许可证核对 target 范围、平台 preset、依赖方式及新增依赖声明；对 SDK 核对 C99 独立编译、真实测试与阶段边界。
4. 每条问题包含 **文件+核实位置+触发条件+影响+修复方向**，按 P0（安全/数据完整性）、P1（行为错误）、P2（维护/性能）、Suggestion 分级；区分确认缺陷和待验证风险。
5. 调用 `../../rules/review-sweep.mdc` 做本次改动全量检查；无 findings 只能说“未发现”，不能宣称无 bug。
6. 说明已审、未审、未运行与 Blocked，提供可复现的验收命令。**不自动修改、提交或推送**；修复须用户再次授权。
