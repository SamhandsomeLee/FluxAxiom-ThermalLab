# 采集当前 Windows 机器的环境，写成 thermallab-env-v1 JSON。
#
# 作用：G0.6 的 Windows 环境记录。由人在开发机上运行，结果提交到 docs/environment/。
# 参数：-OutFile 为输出路径。相对路径相对仓库根目录。省略时写 docs/environment/windows.json。
# 边界：不记录主机名、用户名和绝对路径。不测试 OpenVINO 或 OpenCL，这两项固定为
#       Not Verified。不连接相机、ESP32 或 Jetson，也不读取它们的信息。

param(
    [string]$OutFile = ""
)

$ErrorActionPreference = "Stop"
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
if ([string]::IsNullOrWhiteSpace($OutFile)) {
    $OutFile = Join-Path $RepoRoot "docs/environment/windows.json"
} elseif (-not [System.IO.Path]::IsPathRooted($OutFile)) {
    $OutFile = Join-Path $RepoRoot $OutFile
}

$Os = Get-CimInstance Win32_OperatingSystem
$GpuNames = @(
    Get-CimInstance Win32_VideoController |
        ForEach-Object { [string]$_.Name } |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
)
$NvidiaPresent = $false
foreach ($Name in $GpuNames) {
    if ($Name -match "NVIDIA") {
        $NvidiaPresent = $true
    }
}

$GccVersion = $null
if (Get-Command gcc -ErrorAction SilentlyContinue) {
    $GccVersion = ((& gcc -dumpversion) | Out-String).Trim()
}

$CmakeVersion = $null
if (Get-Command cmake -ErrorAction SilentlyContinue) {
    $CmakeLine = (& cmake --version | Select-Object -First 1 | Out-String).Trim()
    if ($CmakeLine -match "(\d+\.\d+\.\d+)") {
        $CmakeVersion = $Matches[1]
    }
}

$Document = [ordered]@{
    schema              = "thermallab-env-v1"
    platform            = "windows"
    collected_at        = (Get-Date -Format "yyyy-MM-dd")
    os                  = [ordered]@{
        name    = [string]$Os.Caption
        version = [string]$Os.Version
        arch    = [string]$Os.OSArchitecture
    }
    compiler            = [ordered]@{
        id      = "gcc"
        version = $GccVersion
    }
    cmake               = [ordered]@{
        version = $CmakeVersion
    }
    gpus                = $GpuNames
    nvidia_gpu_present  = $NvidiaPresent
    openvino            = "Not Verified"
    opencl              = "Not Verified"
}

$Directory = Split-Path -Parent $OutFile
if (-not (Test-Path -LiteralPath $Directory)) {
    New-Item -ItemType Directory -Path $Directory | Out-Null
}

$Json = $Document | ConvertTo-Json -Depth 5
$Utf8 = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($OutFile, $Json.TrimEnd() + "`n", $Utf8)
Write-Output $OutFile
