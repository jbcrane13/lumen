# Lumen

A SwiftUI design system for iOS 26+ and macOS 26+ built on Apple's Liquid Glass: one accent, capsule controls, concentric corners, SF Pro text styles, and opaque content under floating glass navigation.

> **AI coding agents:** to add Lumen to a project or build UI with it, follow [`plugins/lumen/skills/lumen/SKILL.md`](plugins/lumen/skills/lumen/SKILL.md). It covers adding the package (SwiftPM, XcodeGen, Tuist or a plain `.xcodeproj`), wiring the theme, the full API and the design rules.

## Add it to an app

**Xcode:** File › Add Package Dependencies…, enter `https://github.com/jbcrane13/lumen.git`, Up to Next Major from `1.0.0`, and add the **LumenDesign** library to your app target.

**Package.swift:**

```swift
.package(url: "https://github.com/jbcrane13/lumen.git", from: "1.0.0"),
// target dependency
.product(name: "LumenDesign", package: "lumen"),
```

Then apply the theme once at the root of each scene:

```swift
import SwiftUI
import LumenDesign

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .lumenTheme()
        }
    }
}
```

Set the project's `AccentColor` asset to `accent` (Light `#0066CC`, Dark `#0071E3`) so widgets and system UI outside SwiftUI match.

## Use it with Claude Code

Install the Lumen skill once and Claude will know how to integrate and apply Lumen in any project. Then just say "use the Lumen design system".

```
/plugin marketplace add jbcrane13/lumen
/plugin install lumen@lumen
```

Without installing anything, you can also say: "Use the Lumen design system from github.com/jbcrane13/lumen". The agent note at the top of this README points Claude to the same instructions.

## What you get

| API | Use |
| --- | --- |
| `.lumenTheme()` | Accent tint for every control, tab and prominent glass button below it |
| `Color.Lumen.*` | Every colour token, Light/Dark resolved automatically (`.labelSecondary`, `.accentText`, `.accentSoft`, `.surface`, …) |
| `Lumen.Space.s1…s12` | Spacing: 4, 8, 12, 16, 20, 24, 32, 48 |
| `Lumen.Radius.xs…xxl, .full` | Corners: 6, 10, 16, 24, 34, 48, capsule |
| `Lumen.Size.hitIos / hitMac / controlLarge / tabBar` | Touch targets and fixed heights |
| `Font.Lumen.*` | Dynamic Type styles with Lumen's weights (bold titles, semibold title3) |
| `.lumenNumericDisplay()` | Rounded bold 48pt numbers that scale with Dynamic Type and animate |
| `.buttonStyle(.lumenBordered)` | Secondary button on opaque content (`accent-soft` capsule) |
| `.lumenCard()` | Opaque `surface` card, `radius-l`, concentric container shape |
| `LumenStatusLabel(_:status:)` | Success / warning / danger text that always carries a symbol |
| `LumenSettingsIcon(_:)` | Accent icon tile for list rows |
| `LumenCatalog()` | A screen showing all of the above, with Light and Dark previews |

Everything else comes from SwiftUI itself, used the Lumen way: `.buttonStyle(.glassProminent)` for the one primary action, `.buttonStyle(.glass)` for secondary actions on glass, `.glassEffect()` for custom floating controls, `.listStyle(.insetGrouped)`, `TabView` with `.tabViewStyle(.sidebarAdaptable)`.

## Guidelines

- [Design/Guidelines.md](Design/Guidelines.md): principles, colour, Liquid Glass, typography, layout, motion, states, iconography
- [Design/Components](Design/Components): usage, SwiftUI code and do's and don'ts for each component
- [Design/tokens.json](Design/tokens.json): every token, Light and Dark

## Changing tokens

`Design/tokens.json` is the source. After editing it, regenerate the Swift and commit both:

```bash
python3 Scripts/generate_tokens.py
```

## License

Apache 2.0. See [LICENSE](LICENSE).
