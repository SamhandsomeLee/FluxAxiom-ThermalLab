# 给本仓库自己的 C/C++ 目标打开警告即错误。
#
# **作用**：G0.2 起 GCC/Clang 使用同一组警告。调用方是各目标的 CMakeLists。
# **边界**：不改编译器自带的系统头文件警告。没有 MSVC 选项。
function(thermallab_set_warnings target)
  target_compile_options(
    ${target}
    PRIVATE $<$<COMPILE_LANG_AND_ID:C,GNU,Clang,AppleClang>:-Wall
            -Wextra
            -Wpedantic
            -Werror>
            $<$<COMPILE_LANG_AND_ID:CXX,GNU,Clang,AppleClang>:-Wall
            -Wextra
            -Wpedantic
            -Werror>)
endfunction()
