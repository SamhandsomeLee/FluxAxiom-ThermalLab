# sdk

G0.2 只改版本导出、这个目录的 CMake 和测试。不要在这里做 Y16 回放、温度换算或采集。

## 测试

本机需要 MinGW 的 `gcc` 和 `g++` 在 `PATH` 上，并且设置了 `VCPKG_ROOT`。

```powershell
cmake --preset windows-gcc-debug
cmake --build --preset windows-gcc-debug
ctest --preset windows-gcc-debug -L "unit|golden"
```

`linux-asan` 只在 Linux 上跑。测试不连接相机、ESP32 或网络。
