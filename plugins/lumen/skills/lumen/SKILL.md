---
name: lumen
description: Add the Lumen design system (github.com/jbcrane13/lumen, Swift package LumenDesign) to a SwiftUI app for iOS 26+ / macOS 26+ and build UI that follows it. Use when the user says to use, add, adopt, integrate or follow Lumen, points at the jbcrane13/lumen repo, or writes or restyles SwiftUI views in a project that already imports LumenDesign.
---

# Lumen for SwiftUI

Lumen is a SwiftUI design system built on Apple's Liquid Glass. It ships as the Swift package **LumenDesign** at `https://github.com/jbcrane13/lumen.git` (package identity `lumen`, product `LumenDesign`). Full guidelines live in the repo:

- `Design/Guidelines.md`: principles, colour, glass, type, layout, motion, states, iconography
- `Design/Components/<Name>.md`: Button, Toggle, SegmentedControl, SearchField, List, Card, TabBar, Toolbar, Sheet, Sidebar
- `Design/tokens.json`: every token value

Read them from the resolved package checkout (`…/SourcePackages/checkouts/lumen/Design/` in DerivedData, or `.build/checkouts/lumen/Design/` for SwiftPM) or from `https://raw.githubusercontent.com/jbcrane13/lumen/main/Design/<file>` when you need more detail than this file gives.

Follow the sections in order when integrating. When the package is already integrated, skip to **Building UI with Lumen**.

## 1. Inspect the project

1. Find how dependencies are declared, in this order: `project.yml` (XcodeGen), `Project.swift` (Tuist), `Package.swift` (pure SwiftPM app or a local package the app depends on), otherwise `*.xcodeproj/project.pbxproj`.
2. Check whether Lumen is already there: search those files and any `Package.resolved` for `jbcrane13/lumen`. If found, go to step 3.
3. Check deployment targets. Lumen needs **iOS 26** and **macOS 26** (it uses Liquid Glass APIs). If the app targets anything lower, stop and ask the user before raising it; never add `#available` shims around Lumen.
4. Note every app target that has UI (iOS app, macOS app, widgets, App Clips). Each one that shows SwiftUI gets the dependency.

## 2. Add the dependency

Use version `from: "1.0.0"` (up to next major).

**Package.swift**

```swift
dependencies: [
    .package(url: "https://github.com/jbcrane13/lumen.git", from: "1.0.0"),
],
targets: [
    .target(name: "MyApp", dependencies: [
        .product(name: "LumenDesign", package: "lumen"),
    ]),
]
```

**XcodeGen (`project.yml`)**, then run `xcodegen generate`:

```yaml
packages:
  Lumen:
    url: https://github.com/jbcrane13/lumen.git
    from: 1.0.0
targets:
  MyApp:
    dependencies:
      - package: Lumen
        product: LumenDesign
```

**Tuist (`Project.swift`)**: add `.remote(url: "https://github.com/jbcrane13/lumen.git", requirement: .upToNextMajor(from: "1.0.0"))` to `packages` and `.package(product: "LumenDesign")` to the target's `dependencies`, then `tuist generate`.

**Plain `.xcodeproj`**: make sure the project is committed or copy `project.pbxproj` aside first. Then add these objects, using fresh 24-character uppercase hex IDs that don't already appear in the file (`REF`, `DEP`, `BUILD` below). Keep tabs and the `/* comment */` style the file already uses.

1. `XCRemoteSwiftPackageReference` section (create the section, alphabetically placed among the others, if missing):

   ```
   REF /* XCRemoteSwiftPackageReference "lumen" */ = {
       isa = XCRemoteSwiftPackageReference;
       repositoryURL = "https://github.com/jbcrane13/lumen.git";
       requirement = {
           kind = upToNextMajorVersion;
           minimumVersion = 1.0.0;
       };
   };
   ```

2. `XCSwiftPackageProductDependency` section:

   ```
   DEP /* LumenDesign */ = {
       isa = XCSwiftPackageProductDependency;
       package = REF /* XCRemoteSwiftPackageReference "lumen" */;
       productName = LumenDesign;
   };
   ```

3. In the `PBXProject` object, add `REF /* XCRemoteSwiftPackageReference "lumen" */,` to `packageReferences = ( … );` (create the list if absent).
4. In each app target's `PBXNativeTarget`, add `DEP /* LumenDesign */,` to `packageProductDependencies = ( … );`.
5. In `PBXBuildFile`, add `BUILD /* LumenDesign in Frameworks */ = {isa = PBXBuildFile; productRef = DEP /* LumenDesign */; };` and add `BUILD /* LumenDesign in Frameworks */,` to that target's `PBXFrameworksBuildPhase` `files`. Use a separate `BUILD` ID per target.
6. Run `xcodebuild -resolvePackageDependencies -project <App>.xcodeproj` and confirm it fetches `lumen`. If the file no longer parses (`xcodebuild -list` fails), restore the copy and ask the user to add the package with **File › Add Package Dependencies…** instead.

## 3. Wire up the theme

1. `import LumenDesign` and apply `.lumenTheme()` to the root view of every scene (each `WindowGroup`, `Window`, and the macOS `Settings` scene):

   ```swift
   WindowGroup {
       ContentView()
           .lumenTheme()
   }
   ```

2. Set the app's accent so widgets, notifications and system UI outside SwiftUI match. Write `Assets.xcassets/AccentColor.colorset/Contents.json` (create it if missing; keep it the target's `ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME`, default `AccentColor`):

   ```json
   {
     "colors" : [
       { "color" : { "color-space" : "srgb", "components" : { "alpha" : "1.000", "red" : "0x00", "green" : "0x66", "blue" : "0xCC" } }, "idiom" : "universal" },
       { "appearances" : [ { "appearance" : "luminosity", "value" : "dark" } ],
         "color" : { "color-space" : "srgb", "components" : { "alpha" : "1.000", "red" : "0x00", "green" : "0x71", "blue" : "0xE3" } }, "idiom" : "universal" }
     ],
     "info" : { "author" : "xcode", "version" : 1 }
   }
   ```

3. Build every platform the app ships on and fix anything that breaks:
   `xcodebuild -scheme <Scheme> -destination 'generic/platform=iOS Simulator' build` and `… -destination 'platform=macOS' build`.

## Building UI with Lumen

### The API

| Need | Use |
| --- | --- |
| Tint for the whole app | `.lumenTheme()` at the root (never per view) |
| Colours | `Color.Lumen.<token>`: `bg`, `bgGrouped`, `bgWindow`, `surface`, `surfaceRaised`, `fill`, `fillSecondary`, `fillTertiary`, `label`, `labelSecondary`, `labelTertiary`, `separator`, `separatorOpaque`, `accent`, `accentText`, `onAccent`, `accentSoft`, `focusRing`, `success`, `warning`, `danger`, `scrim` |
| Spacing | `Lumen.Space.s1` 4 · `s2` 8 · `s3` 12 · `s4` 16 · `s5` 20 · `s6` 24 · `s8` 32 · `s12` 48 |
| Corners | `Lumen.Radius.xs` 6 · `s` 10 · `m` 16 · `l` 24 · `xl` 34 · `xxl` 48 · `.capsule` for controls |
| Sizes | `Lumen.Size.hitIos` 44 · `hitMac` 28 · `controlLarge` 50 · `tabBar` 62 |
| Text | `Font.Lumen.largeTitle/title/title2/title3/headline/body/callout/subheadline/footnote/caption/caption2/code` |
| Big numbers | `.lumenNumericDisplay()` |
| Primary action | `.buttonStyle(.glassProminent)` (one per screen) |
| Secondary action on glass | `.buttonStyle(.glass)` |
| Secondary action on opaque content | `.buttonStyle(.lumenBordered)` |
| Tertiary / link | `.buttonStyle(.borderless)` |
| Card | `.lumenCard()`; clip inner images with `ConcentricRectangle()` |
| Status text | `LumenStatusLabel("…", status: .success / .warning / .danger)` |
| List row icon | `LumenSettingsIcon("symbol.name")` |
| Custom floating control | `.glassEffect(.regular.interactive())`; group neighbours in `GlassEffectContainer(spacing: Lumen.Space.s2)` |

`LumenCatalog()` shows everything; add it to a debug menu or a `#Preview` to check the look.

### Rules

- **System first.** Use SwiftUI's own `NavigationStack`, `NavigationSplitView`, `TabView` (`.tabViewStyle(.sidebarAdaptable)`, `Tab(role: .search)`), `List` (`.insetGrouped` on iOS), `Form`, `.toolbar`, `.searchable`, `.sheet`. They already render Liquid Glass. Don't rebuild them.
- **Glass is for navigation only**: bars, toolbars, sidebars, floating buttons. Content (cards, rows, sections) is opaque `surface`. Never glass on glass, never glass on scrolling content, never a background behind toolbars or tab bars.
- **One tint.** `accent` comes from `.lumenTheme()`; don't apply `.tint` elsewhere except to give the one prominent button in a sheet its tint. Tinted text uses `accentText`, never `accent`.
- **No literal values.** No hex, `Color(red:…)`, `.gray`, `.blue`, numeric paddings or radii in views: use the tokens. `.secondary` text → `Color.Lumen.labelSecondary`.
- **Type through text styles only**, never `.system(size:)` except via `.lumenNumericDisplay()`. Bold titles come from `Font.Lumen`.
- **Status never by colour alone**: use `LumenStatusLabel` or pair the colour with a symbol and words.
- **Concentric corners**: inner radius = outer radius − padding (`Radius.l` 24 with `Space.s2` 8 → `Radius.m` 16). Use `.continuous` corner style.
- **Targets**: every tappable thing is at least `Size.hitIos` on touch, `Size.hitMac` on Mac.
- **Copy**: title case for titles, tabs, buttons and menu items; sentence case for headers, footers and messages. Buttons are short verbs ("Save", "Add Photos"); no "OK" when a verb fits; no emoji in UI text.
- **Motion**: `.smooth` for layout, `.snappy` for selection, `.bouncy` only for celebration; respect `accessibilityReduceMotion`.
- **Icons**: SF Symbols only; outline in toolbars and lists, `.fill` for selected tabs.

## Adopting Lumen in an existing app

When the user asks to move an existing app onto Lumen:

1. Integrate (sections 1–3) and build.
2. Search the views for literal styling: `Color(`, `#colorLiteral`, `.foregroundColor(`, `.foregroundStyle(.gray`, `.background(Color.`, `.padding(` with numbers, `cornerRadius:` with numbers, `.font(.system(size:`, custom `ButtonStyle`s and hand-built tab or nav bars.
3. Replace each with the matching token or system component from the tables above. Keep layouts and behaviour the same; this is a restyle, not a redesign. Leave brand assets (logos, illustrations, photos) alone.
4. Remove custom colour assets and style helpers that Lumen now covers only once nothing references them.
5. Build every platform, then show the user a summary: files changed, anything you couldn't map to a token, and anything that needs their decision.
