#!/usr/bin/env python3
"""Generate Sources/LumenDesign/Generated/LumenTokens.swift from Design/tokens.json.

Run from the package root after changing tokens:  python3 Scripts/generate_tokens.py
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TOKENS = ROOT / "Design" / "tokens.json"
OUT = ROOT / "Sources" / "LumenDesign" / "Generated" / "LumenTokens.swift"


def camel(name):
    parts = re.split(r"[-_.]", name)
    out = parts[0] + "".join(p[:1].upper() + p[1:] for p in parts[1:])
    return out if not out[0].isdigit() else "s" + out


def parse_color(value):
    value = value.strip()
    if value.startswith("#"):
        h = value[1:]
        if len(h) in (3, 4):
            h = "".join(c * 2 for c in h)
        r, g, b = (int(h[i:i + 2], 16) for i in (0, 2, 4))
        a = int(h[6:8], 16) / 255 if len(h) == 8 else 1.0
        return r, g, b, a
    m = re.fullmatch(r"rgba?\(\s*([\d.]+)\s*,\s*([\d.]+)\s*,\s*([\d.]+)\s*(?:,\s*([\d.]+)\s*)?\)", value)
    if not m:
        raise ValueError(f"Unsupported color value: {value}")
    r, g, b = (float(m.group(i)) for i in (1, 2, 3))
    return r, g, b, float(m.group(4) or 1)


def rgba_literal(c):
    r, g, b, a = c
    return f"RGBA({r:g}, {g:g}, {b:g}, {round(a, 3):g})"


def doc(text, indent):
    return f"{indent}/// {text}\n" if text else ""


def main():
    t = json.loads(TOKENS.read_text())
    themes = [th["id"] for th in t["color"]["themes"]]
    first = themes[0]
    by_name = {c["name"]: c for c in t["color"]["tokens"]}

    def resolve(token, theme, depth=0):
        v = token["value"]
        v = v if isinstance(v, str) else v.get(theme, v.get(first))
        alias = re.fullmatch(r"\{(.+)\}", v)
        if alias:
            if depth > 16:
                raise ValueError(f"Alias chain too deep at {token['name']}")
            return resolve(by_name[alias.group(1)], theme, depth + 1)
        return parse_color(v)

    lines = [
        "// Generated from Design/tokens.json by Scripts/generate_tokens.py. Do not edit by hand.",
        "",
        "import SwiftUI",
        "",
        "public extension Color {",
        "    /// Lumen colour tokens. Each resolves its Light or Dark value from the current appearance.",
        "    enum Lumen {",
    ]
    for c in t["color"]["tokens"]:
        light, dark = resolve(c, "light"), resolve(c, "dark")
        lines.append(doc(c.get("usage", ""), "        ").rstrip("\n"))
        lines.append(f"        public static let {camel(c['name'])} = Color(light: {rgba_literal(light)}, dark: {rgba_literal(dark)})")
    lines += ["    }", "}", "", "public extension Lumen {"]

    def length_enum(enum, family, strip):
        out = [f"    enum {enum} {{"]
        for tok in t[family]["tokens"]:
            px = float(str(tok["value"]).replace("px", ""))
            name = camel(tok["name"][len(strip):] if tok["name"].startswith(strip) else tok["name"])
            if name == "2xl":
                name = "xxl"
            out.append(doc(tok.get("usage", ""), "        ").rstrip("\n"))
            out.append(f"        public static let {name}: CGFloat = {px:g}")
        out.append("    }")
        return out

    lines += length_enum("Space", "spacing", "space-")
    lines.append("")
    lines += length_enum("Radius", "radius", "radius-")
    lines.append("")
    size_tokens = {"tokens": [x for x in t["size"]["tokens"] if x["name"] != "glass-blur"]}
    t["size_native"] = size_tokens
    lines += length_enum("Size", "size_native", "")
    lines += ["}", ""]

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(l for l in lines if l != "") .replace("\n}\npublic extension", "\n}\n\npublic extension") + "\n")
    print(f"Wrote {OUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
