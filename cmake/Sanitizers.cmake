# 在 Linux 预设 linux-asan 上打开 ASan、UBSan 和 LSan。
#
# **作用**：给库和测试加上同一组 sanitizer，避免只检测一侧。
# **参数**：`target` 是已经创建的 CMake 目标。
# **边界**：`THERMALLAB_ENABLE_SANITIZERS` 关闭时什么都不做。根 CMakeLists 拒绝在
# Linux 以外打开该选项。
function(thermallab_enable_sanitizers target)
  if(NOT THERMALLAB_ENABLE_SANITIZERS)
    return()
  endif()
  target_compile_options(${target} PRIVATE -fsanitize=address,undefined,leak
                                            -fno-omit-frame-pointer)
  target_link_options(${target} PRIVATE -fsanitize=address,undefined,leak)
endfunction()
