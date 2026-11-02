# 第三方许可证

核对日期一律是 2026-11-02，除非某一行另写。版本写「未引入」表示这个组件还没有进仓库，也没有锁定引入时的版本。

| 名称 | vcpkg | 版本 | 许可证 | 链接方式 | 来源 URL | 核对日期 |
| --- | --- | --- | --- | --- | --- | --- |
| GoogleTest | gtest | 1.18.0 | BSD-3-Clause | 测试可执行文件静态链接，不链进 `thermallab` | https://github.com/google/googletest/blob/v1.18.0/LICENSE | 2026-10-28 |
| vcpkg-cmake | vcpkg-cmake | 2025-08-07 | MIT | 只在 vcpkg 配置 gtest 时使用，不链进 SDK | https://github.com/microsoft/vcpkg/blob/15b12b99a227d51e21c86dffd40385439eac87a0/ports/vcpkg-cmake/vcpkg.json | 2026-10-28 |
| vcpkg-cmake-config | vcpkg-cmake-config | 2026-07-21 | MIT | 只在 vcpkg 配置 gtest 时使用，不链进 SDK | https://github.com/microsoft/vcpkg/blob/15b12b99a227d51e21c86dffd40385439eac87a0/ports/vcpkg-cmake-config/copyright | 2026-10-28 |
| Qt | 未引入 | 未引入 | LGPLv3 | 动态链接。不使用下面核对页列出的 GPLv3 模块 | https://doc.qt.io/qt-6/licensing.html | 2026-11-02 |
| FFmpeg | 未引入 | 未引入 | LGPLv2.1+ | 动态链接。配置不加 `--enable-gpl`、`--enable-nonfree`，不用 libx264 | https://www.ffmpeg.org/legal.html | 2026-11-02 |
| OpenH264 | 未引入 | 未引入 | BSD-2-Clause | 软件 H.264 编码用它，不用 x264 | https://raw.githubusercontent.com/cisco/openh264/master/LICENSE | 2026-11-02 |
| MediaMTX | 未引入 | 未引入 | MIT | 独立进程 | https://raw.githubusercontent.com/bluenviron/mediamtx/main/LICENSE | 2026-11-02 |
| ONNX Runtime | 未引入 | 未引入 | MIT | 随包分发。尚未引入 | https://raw.githubusercontent.com/microsoft/onnxruntime/main/LICENSE | 2026-11-02 |
| OpenVINO | 未引入 | 未引入 | Apache-2.0 | 随包分发。尚未引入 | https://raw.githubusercontent.com/openvinotoolkit/openvino/master/LICENSE | 2026-11-02 |
| CUDA Toolkit | 未引入 | 未引入 | NVIDIA 专有 EULA | 不放入仓库，不随包分发，依赖本机或 JetPack | https://docs.nvidia.com/cuda/eula/index.html | 2026-11-02 |
| TensorRT 二进制 | 未引入 | 未引入 | NVIDIA 专有，不把 GitHub 仓库 LICENSE 当作二进制许可 | 不放入仓库，不随包分发，依赖 JetPack | https://raw.githubusercontent.com/NVIDIA/TensorRT/main/LICENSE | 2026-11-02 |
| YOLOX | 未引入 | 未引入 | Apache-2.0 | 检测模型候选。不下载权重，不复制进仓库 | https://raw.githubusercontent.com/Megvii-BaseDetection/YOLOX/main/LICENSE | 2026-11-02 |
| 睿创微纳红外开源平台 | 未引入 | 未引入 | 超分数据库版权声明，仅核对此库 | 不放入仓库。下载该库要先申请并获批准 | http://openai.raytrontek.com/apply/E_Super_resolution.html/ | 2026-11-02 |
| MySQL Connector/C++ | 未引入 | 未引入 | GPLv2 + Universal FOSS Exception | 动态链接 | https://raw.githubusercontent.com/mysql/mysql-connector-cpp/trunk/LICENSE.txt | 2026-11-02 |
| libuvc | 未引入 | 未引入 | BSD-3-Clause | 只参考协议与数据布局，不复制代码 | https://raw.githubusercontent.com/libuvc/libuvc/master/LICENSE.txt | 2026-11-02 |
| P2Pro-Viewer | 未引入 | 未引入 | MIT | 只参考协议与数据布局，不复制代码 | https://raw.githubusercontent.com/LeoDJ/P2Pro-Viewer/master/LICENSE | 2026-11-02 |

白名单脚本是 `scripts/check_license_allowlist.py`。它只放行上表里 `vcpkg` 列不是「未引入」且许可证属于 MIT、BSD-2-Clause、BSD-3-Clause、Apache-2.0、Zlib、BSL-1.0 的直接依赖。

## 已核对的范围

- gtest 端口与两条 vcpkg 脚本端口的核对范围仍是 2026-10-28 那一节：baseline `15b12b99a227d51e21c86dffd40385439eac87a0` 的端口声明和 LICENSE / copyright 正文。没有重读这些仓库的其它文件。
- Qt：打开了 Qt 6 文档的 Licensing 页。开源框架写的是 LGPLv3。该页「Modules available under GNU General Public License v3」下列出 Qt Canvas Painter、Qt CoAP、Qt Graphs、Qt GRPC、Qt HTTP Server、Qt Lottie Animation、Qt MQTT、Qt Network Authorization、Qt Qml Compiler、Qt Quick 3D、Qt Quick 3D Physics、Qt Quick Timeline、Qt Virtual Keyboard、Qt Wayland Compositor。没有打开这些模块各自的页面。该列表没有 Qt Charts，也没有打开 Qt Charts 的单独页面。设计文档 §6.5 写 Qt Charts 在开源版是 GPLv3；这一页不能当成对 Qt Charts 的核对。LTS 版本号仍留到 ADR-013，不在这里锁定。
- FFmpeg：打开了 Legal 页的许可证节和合规清单。默认是 LGPLv2.1 或更新版本；启用 GPL 部件后整个 FFmpeg 适用 GPL。清单第 1、2、18 条要求不要 `--enable-gpl` / `--enable-nonfree`、动态链接、不要用 libx264。没有把专利问答写成专利结论。
- OpenH264：读了仓库 `LICENSE` 全文。它是保留版权声明的二条款 BSD，文件里没有专利授权段落。没有打开同目录以外的文件。
- MediaMTX：读了 `LICENSE` 开头，是 MIT，版权行是 Copyright (c) 2019 aler9。没有读完仓库其它文件。
- ONNX Runtime：读了 `LICENSE` 开头，是 MIT，版权持有人是 Microsoft Corporation。
- OpenVINO：读了 `LICENSE` 开头，是 Apache-2.0。没有核对 `master` 上的版本号。
- CUDA：打开了 CUDA Toolkit EULA 页。页首写 NVIDIA Software License Agreement and CUDA Supplement，Last updated: January 26, 2026。读了前言，没有逐条读完全部条款。
- TensorRT：读了 `NVIDIA/TensorRT` 仓库 `LICENSE`。文件以 Apache-2.0 开始，在 Apache 附录结束，文件中没有 “proprietary” 或 “NVIDIA Software License” 字样。这只说明该 GitHub 树的 LICENSE 文件是 Apache-2.0，不说明 NVIDIA 分发的 TensorRT 二进制可以入库或随包分发。二进制仍不入库。
- YOLOX：读了 `LICENSE`。正文是 Apache-2.0，附录版权行是 Copyright (c) 2021-2022 Megvii Inc.。用户写的选择是「YOLO」。Ultralytics YOLO 的 `LICENSE` 以 GNU Affero General Public License Version 3 开头，不使用。检测模型落到 YOLOX，不下载权重。
- 数据集：用户写的是「睿纳维创官方提供」。2026-11-02 的公开检索没有这个名称的数据集。设计文档里的岗位公司是睿创微纳。打开的是睿创微纳 / Yantai IRay 红外开源平台上的红外超分数据库英文页。版权声明允许在保留完整版权声明、并在使用该库的出版物中注明 Raytron Technology Co., Ltd（https://en.raytrontek.com/）的前提下，为任何目的使用、复制、修改和分发该数据库（图像、results、源文件）及其文档。同一页写明下载要先提交申请，批准后把地址发到邮箱。没有打开平台上其它数据集的版权声明，不能把这段话写成整个平台的许可。这段话没有授权公开发布用这些数据训练出的模型权重。数据文件不放入本仓库。
- MySQL Connector/C++：打开仓库 `trunk/LICENSE.txt`。文件自称为 MySQL Connector/C++ 26.10.0 Community，这是被打开的那份文件的版本，不是本仓库锁定的版本。文件选举 GPLv2，并写明适用 Universal FOSS Exception 1.0，地址 http://oss.oracle.com/licenses/universal-foss-exception 。该例外允许与带完整源码、OSI 批准或 FSF 认定为自由软件的其它软件做接口级互操作和链接，不把对方软件改成 GPL；它不授权与非这类软件一起分发。本仓库许可证是 MIT。旧的 MySQL FOSS License Exception 页写明自 MySQL Community 8.0.4（2018-01-24）起，新版本客户端库改用 Universal FOSS Exception。没有阅读 GPLv2 全文。不选用 MariaDB Connector/C。
- libuvc：读了 `LICENSE.txt` 全文，三条款 BSD，版权 Copyright (C) 2010-2015 Ken Tossell。
- P2Pro-Viewer：读了 `LICENSE` 开头，MIT，版权 Copyright (c) 2023 LeoDJ。
