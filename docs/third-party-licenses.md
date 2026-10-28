# 第三方许可证

本文件随新增依赖更新。设计文档 §6.5 的其余组件在 G0.7 核对，这里还没有它们的结论。

| 名称 | 版本 | 许可证 | 链接方式 | 来源 URL | 核对日期 |
| --- | --- | --- | --- | --- | --- |
| GoogleTest | 1.18.0 | BSD-3-Clause | 测试可执行文件静态链接，不链进 `thermallab` 动态库 | https://github.com/google/googletest/blob/v1.18.0/LICENSE | 2026-10-28 |
| vcpkg-cmake | 2025-08-07 | MIT | 只在 vcpkg 配置 gtest 时使用，不链进 SDK | https://github.com/microsoft/vcpkg/blob/15b12b99a227d51e21c86dffd40385439eac87a0/ports/vcpkg-cmake/vcpkg.json | 2026-10-28 |
| vcpkg-cmake-config | 2026-07-21 | MIT | 只在 vcpkg 配置 gtest 时使用，不链进 SDK | https://github.com/microsoft/vcpkg/blob/15b12b99a227d51e21c86dffd40385439eac87a0/ports/vcpkg-cmake-config/copyright | 2026-10-28 |

核对范围：baseline `15b12b99a227d51e21c86dffd40385439eac87a0`。

- gtest 端口 `vcpkg.json` 写明 `version-semver` 1.18.0 和 `license` BSD-3-Clause。同一天打开 tag `v1.18.0` 的 `LICENSE`，正文是三条 BSD 条件（保留版权声明、二进制再分发附带声明、不得用 Google 名称背书）。没有核对这个仓库的其它文件。
- `vcpkg-cmake` 的 `vcpkg.json` 写明 `license` MIT。端口目录里没有 `copyright` 文件。安装结果里的 `copyright` 是 MIT 全文。
- `vcpkg-cmake-config` 的 `vcpkg.json` 写明 `license` MIT，端口 `copyright` 是 MIT 全文。安装结果里的文本与它一致。
