#!/bin/sh
# 采集当前 Linux 或 Jetson 的环境，写成 thermallab-env-v1 JSON。
#
# 作用：在目标机本地运行，供 G0.6 清单引用。存在 /etc/nv_tegra_release 时视为 Jetson。
# 参数：$1 为输出文件。省略时，Jetson 写 docs/environment/jetson.json，
#       其它 Linux 写 docs/environment/linux.json。相对路径相对仓库根目录。
# 边界：不记录主机名和绝对路径。不通过 SSH 采集另一台机器。OpenVINO 与 OpenCL
#       固定写 Not Verified。没有 gcc 或 cmake 时版本写 null。不修改系统配置。

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/../.." && pwd)

platform=linux
default_name=linux.json
tegra_line=null
if [ -f /etc/nv_tegra_release ]; then
    platform=jetson
    default_name=jetson.json
    tegra_raw=$(head -n 1 /etc/nv_tegra_release)
fi

out_file=${1:-"$repo_root/docs/environment/$default_name"}
case $out_file in
    /*) ;;
    *) out_file=$repo_root/$out_file ;;
esac

json_escape() {
    printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

os_name=unknown
if [ -r /etc/os-release ]; then
    os_name=$(. /etc/os-release && printf '%s' "${PRETTY_NAME:-unknown}")
fi
os_version=$(uname -r)
os_arch=$(uname -m)

gcc_version=null
if command -v gcc >/dev/null 2>&1; then
    gcc_version=$(gcc -dumpversion 2>/dev/null || true)
    if [ -n "$gcc_version" ]; then
        gcc_version='"'"$(json_escape "$gcc_version")"'"'
    else
        gcc_version=null
    fi
fi

cmake_version=null
if command -v cmake >/dev/null 2>&1; then
    cmake_line=$(cmake --version 2>/dev/null | head -n 1 || true)
    cmake_num=$(printf '%s' "$cmake_line" | sed -n 's/.*\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*/\1/p')
    if [ -n "$cmake_num" ]; then
        cmake_version='"'"$(json_escape "$cmake_num")"'"'
    fi
fi

nvidia_present=false
gpu_json=
if command -v nvidia-smi >/dev/null 2>&1; then
    nvidia_present=true
    gpu_name=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -n 1 || true)
    if [ -n "$gpu_name" ]; then
        gpu_json='"'"$(json_escape "$gpu_name")"'"'
    fi
fi
if [ "$platform" = jetson ]; then
    nvidia_present=true
fi

if [ -n "${tegra_raw:-}" ]; then
    tegra_line='"'"$(json_escape "$tegra_raw")"'"'
fi

if [ -z "$gpu_json" ]; then
    gpu_json=
fi

collected_at=$(date +%Y-%m-%d)
mkdir -p "$(dirname -- "$out_file")"

if [ -n "$gpu_json" ]; then
    gpus_json="[$gpu_json]"
else
    gpus_json="[]"
fi

cat >"$out_file" <<EOF
{
  "schema": "thermallab-env-v1",
  "platform": "$platform",
  "collected_at": "$collected_at",
  "os": {
    "name": "$(json_escape "$os_name")",
    "version": "$(json_escape "$os_version")",
    "arch": "$(json_escape "$os_arch")"
  },
  "compiler": {
    "id": "gcc",
    "version": $gcc_version
  },
  "cmake": {
    "version": $cmake_version
  },
  "gpus": $gpus_json,
  "nvidia_gpu_present": $nvidia_present,
  "nv_tegra_release": $tegra_line,
  "openvino": "Not Verified",
  "opencl": "Not Verified"
}
EOF

printf '%s\n' "$out_file"
