# ADR-014：许可证与依赖选择

- 状态：草案
- 日期：2026-11-02
- 依据：执行方案 v1.0 §4.2.1 G0.7、§8.2；设计文档 V2.0 §6.5；`docs/third-party-licenses.md`

## 背景

G0 要选定能进仓库的许可证，避免做到 G3 才发现模型或客户端库不能公开分发。G0.7 已经按用户的选择核对过一轮，并写进许可证表。这一份 ADR 记录那些选择。它不把尚未逐页核对的范围扩成已经允许。

## 决定

- 仓库许可证是 MIT。
- 直接使用的许可证限于 MIT、BSD、Apache-2.0、Zlib、BSL-1.0。
- Qt 开源框架按 LGPLv3 动态链接。2026-11-02 打开的 Qt 6 Licensing 页把一批模块列为 GPLv3，其中有 Qt Graphs。这些模块不使用。该页没有列出 Qt Charts，也没有打开 Qt Charts 的单独页面，所以不把 Qt Charts 写成已经核对为 GPLv3，但同样不使用。Qt LTS 版本号不在这里锁定。
- FFmpeg 使用不加 `--enable-gpl` 和 `--enable-nonfree` 的 LGPLv2.1 或更新版本，并且动态链接。软件 H.264 用 OpenH264，不用 x264。
- MediaMTX 以 MIT 独立进程部署。ONNX Runtime 为 MIT，OpenVINO 为 Apache-2.0。二者都还没有引入。
- CUDA Toolkit 适用 NVIDIA 专有 EULA。TensorRT 二进制不放入仓库、不随包分发，依赖本机或 JetPack。`NVIDIA/TensorRT` 仓库里的 `LICENSE` 是 Apache-2.0，只覆盖那棵 Git 树，不作为二进制 SDK 可以随包分发的许可。
- 检测模型用 YOLOX，Apache-2.0。不下载权重。Ultralytics YOLO 的 `LICENSE` 是 AGPL-3.0，不使用。
- 红外数据来源按用户所写的「睿纳维创官方提供」核对到睿创微纳红外开源平台。只读了超分数据库的版权声明：保留完整版权声明并注明来源后，可以为任何目的使用、复制、修改和分发该数据库及其文档；下载要先申请并获批准。这段话没有授权公开发布训练得到的模型权重。平台上其它数据集没有逐个打开。数据文件不放入本仓库。
- MySQL 客户端用 Connector/C++，动态链接，尚未引入。许可证是 GPLv2 加上 Universal FOSS Exception 1.0。不使用 2018 年页面已声明弃用的旧 MySQL FOSS License Exception。不选 MariaDB Connector/C。该例外不覆盖 MySQL 服务器，也不允许与非自由软件捆在一起分发。
- P2 Pro 参考实现只参考协议和数据布局。libuvc 是 BSD-3-Clause，P2Pro-Viewer 是 MIT。复制代码之前再核对当时的许可证，并在文件头写来源。
- 尚未引入的组件，版本写「未引入」。新增依赖、模型或数据集时，同一轮更新 `docs/third-party-licenses.md`。

## 备选与取舍

| 方案 | 代价 | 不采用的原因 |
| --- | --- | --- |
| MariaDB Connector/C，LGPL，动态链接 | 少一个 GPL 例外 | 用户在 G0.7 选定 Connector/C++ |
| Ultralytics YOLO | 权重和工具现成 | `LICENSE` 是 AGPL-3.0，规则不允许 |
| 把睿创微纳平台上的全部数据集都写成与超分库同一许可 | 看起来可以马上训练并发布模型 | 只读了一个库的版权声明，且该声明没有写模型权重 |

## 证据

核对日期和读过的页面记在 `docs/third-party-licenses.md` 的「已核对的范围」。白名单脚本是 `scripts/check_license_allowlist.py`，`linux-debug` 会运行它。2026-11-02 在本机对当时的表运行过：通过；把 gtest 的许可证改成 GPL、以及在文件中写入「待定」，都会被拒绝。没有把这些失败用例留在仓库里。

没有逐条读完 CUDA EULA。没有打开 Qt Charts 的单独页面。没有打开睿创微纳平台上超分库以外的数据集版权声明。

## 后果

- 在 Connector/C++ 真正进入构建之前，它保持「未引入」。引入时要动态链接，并带上 GPLv2 与 Universal FOSS Exception 的文本。
- 用超分库之外的睿创微纳数据，或要公开发布微调权重之前，先补读那一份版权声明。不允许发布权重时，改用自采数据，并修订本 ADR。
- Qt LTS 版本仍留到 ADR-013。ADR-013 因没有 Jetson 实测版本，这次不写、不标已采用。
- 若白名单要把 Connector/C++ 放进 `vcpkg.json`，先改脚本里的「未引入」条件，再引入依赖。
