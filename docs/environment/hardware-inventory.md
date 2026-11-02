# 硬件与环境清单

采集日期：2026-11-02。缺失项的预计到位日期写「未定」表示还没有日期，不是空白。

Windows 环境由 `scripts/env/collect.ps1` 写入 `docs/environment/windows.json`。Linux 与 Jetson 的脚本是 `scripts/env/collect.sh`，这两台机器还没有运行过，所以没有对应 JSON。

## 设计文档 §14.1

| 条目 | 状态 | 预计到位日期 | 受影响工作包 |
| --- | --- | --- | --- |
| Jetson 型号与内存 | NVIDIA Jetson Orin Nano Super Developer Kit，8 GB。内存来自套件名称，未在板上读取 | 已有型号 | G0.4、G0.8 |
| JetPack、L4T、CUDA、TensorRT | Blocked。2026-11-02 起暂时拿不到 Jetson，未采集，不猜测 | 未定 | G0.4、G0.5、G0.8、G3.6 |
| 硬件视频编码器 | 设计文档 §6.2 写 Orin Nano 没有硬件编码器。尚未在这块板上确认 | 未定 | G5.2 |
| InfiRay P2 Pro | 未到手。原始数据布局、帧率和温度公式未核实 | 未定 | G1.8、G2.9 |
| x86 开发机 | 见下方 Windows 小节。没有 NVIDIA GPU。OpenVINO GPU 与 OpenCL 为 Not Verified | 已采集系统与 GPU 名称 | G2.10、G3.5 |
| ESP32 | 型号 DNESP32S3M。蜂鸣器、LED、光敏元件未确认。舵机云台与温湿度传感器未确认 | 未定 | G4.7；光敏元件另影响 G5.3 |
| 可见光 UVC 摄像头 | 没有 | 未定 | G2.9、G5.3 |
| 检测模型与红外数据集许可证，以及能否公开发布衍生模型 | 尚未选择 | 未定 | G0.7、G3.1 |
| Qt LTS | 尚未选择。G0.2 已决定留到 G0.8 的 ADR-013 | 未定 | G0.8、G2 |
| MySQL 客户端库 | 尚未选择 | 未定 | G0.7、G3.11 |
| 2027 年春节假期 | 国务院尚未公布，G4 排期未修正 | 公布后 | G4 |

P2 Pro 未到手不改变 G1 的温度路径。执行方案已确定合成 Y16 先于实机录制。这一刀不另选官方数据集。

## Windows

来源：`docs/environment/windows.json`，2026-11-02 在开发机上运行 `scripts/env/collect.ps1`。

- 系统：Microsoft Windows 11 家庭版 中文版，版本 10.0.26200，64 位。
- 本机编译器：PATH 上的 gcc 15.2.0。CI 的 Windows 作业另用 2026-09-27 MSYS2 安装包里的 GCC 16.2.0-4，与本机主版本不同。
- CMake：4.1.2。
- 显示设备名称：GameViewer Virtual Display Adapter、OrayIddDriver Device、Intel(R) Arc(TM) 130T GPU (16GB)。前两个名称是虚拟显示适配器。WMI 的 AdapterRAM 会溢出，脚本不记录它，名称里的 16GB 也不当作实测显存。
- NVIDIA GPU：没有。
- OpenVINO、OpenCL：Not Verified。没有运行过。

## Linux

未采集。预计到位日期未定。在 Linux 机器上运行：

```sh
scripts/env/collect.sh docs/environment/linux.json
```

## Jetson

型号按用户声明记录。2026-11-02 起暂时拿不到这块板，环境 JSON 与 JetPack、L4T、CUDA、TensorRT 标为 `Blocked`，预计到位日期未定。不在清单里猜测版本。板子回到手上之后，在板上运行：

```sh
scripts/env/collect.sh docs/environment/jetson.json
```

脚本看到 `/etc/nv_tegra_release` 时会把平台写成 `jetson`，并记录该文件的第一行。JetPack、CUDA、TensorRT 仍等这次采集。
