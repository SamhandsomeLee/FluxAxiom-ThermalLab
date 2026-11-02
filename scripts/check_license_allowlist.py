#!/usr/bin/env python3
"""核对 vcpkg 直接依赖和许可证表，拦住 GPL / AGPL。

作用：G0.7 的 CI 检查。读仓库根的 `vcpkg.json` 与
`docs/third-party-licenses.md`，确认每个直接依赖都有一行，且许可证在允许名单里。
参数：无。路径相对当前工作目录，应在仓库根运行。
边界：不访问网络，不检查传递依赖。许可证单元格含 AGPL 则失败。含 GPL 时，
只有「GPLv2 + Universal FOSS Exception」且版本、vcpkg 列都是「未引入」、
链接方式是「动态链接」才通过。文件里出现「待定」则失败。LGPL 行必须写动态链接。
"""

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
VCPKG = ROOT / "vcpkg.json"
LICENSES = ROOT / "docs" / "third-party-licenses.md"
ALLOWED = {
    "MIT",
    "BSD-2-Clause",
    "BSD-3-Clause",
    "Apache-2.0",
    "Zlib",
    "BSL-1.0",
}
GPL_EXCEPTION = "GPLv2 + Universal FOSS Exception"
NOT_INTRODUCED = "未引入"
DYNAMIC = "动态链接"


def fail(message: str) -> None:
    print(f"license allowlist: {message}", file=sys.stderr)
    raise SystemExit(1)


def parse_table(text: str) -> list[dict[str, str]]:
    rows: list[dict[str, str]] = []
    header: list[str] | None = None
    for line in text.splitlines():
        if not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if all(set(cell) <= set("-: ") and cell for cell in cells):
            continue
        if header is None:
            header = cells
            continue
        if len(cells) != len(header):
            fail(f"table row has {len(cells)} cells, header has {len(header)}: {line}")
        rows.append(dict(zip(header, cells)))
    if header is None:
        fail("license table not found")
    for column in ("名称", "vcpkg", "版本", "许可证", "链接方式"):
        if column not in header:
            fail(f"license table is missing column {column}")
    return rows


def license_kind(value: str) -> str:
    upper = value.upper()
    if "AGPL" in upper:
        return "agpl"
    if "GPL" in upper.replace("LGPL", ""):
        return "gpl"
    if "LGPL" in upper:
        return "lgpl"
    return "other"


def main() -> None:
    text = LICENSES.read_text(encoding="utf-8")
    if "待定" in text:
        fail("license file contains 待定")
    rows = parse_table(text)
    by_port = {row["vcpkg"]: row for row in rows if row["vcpkg"] != NOT_INTRODUCED}
    manifest = json.loads(VCPKG.read_text(encoding="utf-8"))
    dependencies = manifest.get("dependencies", [])
    for dependency in dependencies:
        if not isinstance(dependency, str):
            fail(f"unsupported vcpkg dependency entry: {dependency!r}")
        row = by_port.get(dependency)
        if row is None:
            fail(f"vcpkg dependency {dependency} has no license row")
        if row["许可证"] not in ALLOWED:
            fail(f"{dependency} license {row['许可证']} is not in the allowlist")
    for row in rows:
        kind = license_kind(row["许可证"])
        if kind == "agpl":
            fail(f"{row['名称']} is AGPL")
        if kind == "gpl":
            if (
                row["许可证"] != GPL_EXCEPTION
                or row["版本"] != NOT_INTRODUCED
                or row["vcpkg"] != NOT_INTRODUCED
                or DYNAMIC not in row["链接方式"]
            ):
                fail(f"{row['名称']} GPL row is not the recorded Connector/C++ exception")
        if kind == "lgpl" and DYNAMIC not in row["链接方式"]:
            fail(f"{row['名称']} is LGPL and must be dynamically linked")
    print(f"license allowlist: {len(dependencies)} vcpkg dependencies, {len(rows)} rows")


if __name__ == "__main__":
    main()
