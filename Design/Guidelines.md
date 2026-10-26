# Lumen Guidelines

Lumen is a design system for SwiftUI apps on iPhone, iPad and Mac that sits naturally beside Apple's own apps in the Liquid Glass era. It does not restyle the platform; it decides how to use it: which system materials, which type styles, which spacing and corner geometry, and one accent that gives the app its identity.

Build with the system first. Reach for a Lumen token only where SwiftUI leaves a choice open (the tint, a card's padding, a corner radius, a stat's type style).

## Principles

- **Content first, chrome floats.** Content runs edge to edge under the status bar and behind toolbars. Navigation (tab bars, toolbars, sidebars) floats above it on Liquid Glass. Never put glass on content itself: cards, rows and list sections are opaque `surface`.
- **One tint.** `accent` is the only brand colour in the UI. Everything else is neutral or a status. A screen has one prominent (filled) action at most.
- **Capsules and concentric corners.** Controls are capsules (`radius-full`). Containers nest concentrically: an inner shape's radius equals the outer radius minus the padding between them (`radius-l` 24 with 8pt padding → `radius-m` 16).
- **Dynamic by default.** Every text uses a text style, never a fixed size; every colour has a dark value; every interactive element clears `hit-ios` (44pt) or `hit-mac` (28pt).

## Content fundamentals

- Voice: plain, calm, second person. "You", never "the user"; "we" only for the app apologising ("We couldn't save your changes").
- Casing: title case for navigation titles, tab labels, buttons and menu items ("Add to Library"). Sentence case for everything else: section headers, footers, alerts' messages, placeholders.
- Buttons are verbs, two words at most: "Save", "Add Photos", "Try Again". Never "OK" when a verb fits; never "Yes/No".
- Errors say what happened and what to do: "Couldn't sync. Check your connection and try again." No codes in the headline.
- Numbers: digits always, `.monospacedDigit()` wherever they change in place. Dates through `.formatted()`, never hand-built strings.
- No emoji in UI text. SF Symbols carry the pictures.

## Colour

Tokens come in Light and Dark; SwiftUI resolves them from the asset catalog (see Using Lumen in SwiftUI).

- Grounds: `bg` for plain lists and media; `bg-grouped` behind inset-grouped lists; `bg-window` for Mac window content. Rows, cards and sheets sit on them as `surface`; things nested inside a surface use `surface-raised`.
- Text: `label` for anything a person must read; `label-secondary` for subtitles and values (it is darker than the system `.secondary` so it holds 4.5:1 on every ground); `label-tertiary` only for placeholders, disabled text and chevrons.
- Tint: `accent` fills (prominent buttons, selected switch, slider) always carry `on-accent` text. Tinted text and glyphs use `accent-text`, which is brighter in Dark so it reads on black. Selected rows and tinted bordered buttons use `accent-soft` with `accent-text` on top.
- Status: `success`, `warning`, `danger` are text-safe on `bg`, `bg-grouped` and `surface`. Always pair them with an SF Symbol or a word; never let colour be the only signal.
- Hairlines: `separator` at 0.5pt between rows, inset to the text's leading edge.

## Liquid Glass

Glass is the navigation layer. It belongs on tab bars, toolbars, sidebars, floating action buttons, search fields at the bottom of the screen, and the controls inside them. SwiftUI's own bars, sheets, menus and popovers already use it: don't add glass to them again.

- Custom floating controls: `.glassEffect()` (default `.regular`, capsule shape). Make it respond to touch with `.glassEffect(.regular.interactive())`.
- Primary action on glass: `.buttonStyle(.glassProminent)` with the accent as `.tint`. Secondary actions: `.buttonStyle(.glass)`.
- Group neighbouring glass elements in one `GlassEffectContainer(spacing:)` (use `space-2`) so they blend and morph together instead of stacking.
- Never stack glass on glass, never tint every glass element (tint only the one primary action), never put glass on scrolling content.
- Reduce Transparency and Increase Contrast are handled by the system for real glass. The web stand-in in these previews (`glass-fill`, `glass-stroke`, `glass-highlight`, `glass-blur`, `shadow-glass`) exists only so the pages can show the look; do not port those values into SwiftUI.

## Typography

SF Pro is the only typeface; it is built into every Apple platform, so there are no font files to ship. Set every text with a text style so it follows Dynamic Type.

- iOS and iPadOS use the `ios-…` styles; Mac uses the `mac-…` styles. In SwiftUI the same `.font(.body)` resolves to the right one on each platform: the two groups document what each resolves to.
- Lumen's opinion is in the weights: large titles and titles are bold, `title3` and `headline` semibold, everything else regular. Never use light or thin weights.
- `numeric-display` (SF Pro Rounded, bold, monospaced digits) is for stats, timers and widgets. `code` (SF Mono) is for identifiers and logs.
- Leading and tracking come from the system: don't set `.tracking` or `.lineSpacing` on text styles.
- Scale custom metrics with Dynamic Type: `@ScaledMetric(relativeTo: .body) var iconSize = 22`.

## Spacing and layout

- Margins: `space-4` (16pt) on iPhone, `space-5` (20pt) on iPad and Mac. Respect safe areas; let backgrounds extend under bars with `.backgroundExtensionEffect()` where an image should reach behind a sidebar.
- Rhythm: `space-2` between related items, `space-4` inside cards, `space-6` between sections, `space-8` above a section heading.
- Targets: `hit-ios` 44pt on touch, `hit-mac` 28pt on Mac. A 17pt glyph in a toolbar still gets a 44pt frame.
- Bottom-pinned prominent buttons use `control-large` height, full width minus margins, capsule.
- Size classes, not devices: compact width gets a tab bar; regular width gets a sidebar (`NavigationSplitView`, or `.tabViewStyle(.sidebarAdaptable)` to get both from one `TabView`).

## Corners and depth

- Controls: `radius-full`. Cards and list sections: `radius-l`. Sheets and big panels: `radius-xl`. Thumbnails and menus: `radius-m`. Mac fields: `radius-s`.
- Prefer concentric shapes over picking a number: inside a container use `ConcentricRectangle()` (or `.rect(cornerRadius:)` with outer minus padding). Always use `style: .continuous` corners when drawing your own `RoundedRectangle`.
- Depth comes from glass and grouping, not shadows. Opaque content gets no shadow; only lifted Mac cards on hover use `shadow-raised`.

## Motion

- Default to springs: `.smooth` for layout and navigation, `.snappy` for toggles and selection, `.bouncy` only for playful confirmation (a like, a completed goal).
- Morph glass between states with `.glassEffectID(_:in:)` inside a `GlassEffectContainer` rather than fading.
- Check `@Environment(\.accessibilityReduceMotion)` and replace movement with a cross-fade when it is on.

## States

- Pressed: system controls handle it; for custom glass use `.interactive()`. Custom opaque rows highlight to `fill-tertiary`.
- Selected: `accent-soft` behind `accent-text` (sidebar rows, chips); tab bar items switch to the filled symbol in `accent-text`.
- Disabled: `label-tertiary` text, no fill change, `.disabled(true)` so VoiceOver announces it.
- Focus (iPad keyboard, Mac): 3pt solid `focus-ring`, 2pt outside the shape, following its corners. It holds 3:1 on every ground in both themes.

## Iconography

- SF Symbols only, at the text style they sit beside (`Image(systemName:)` inherits `.font`). Outline in toolbars and lists; `.fill` variant for the selected tab. Prefer `.symbolRenderingMode(.hierarchical)` for multi-part symbols.
- Animate with `.symbolEffect(...)` sparingly: `.bounce` on a confirmed action, `.pulse` while waiting.
- Status pairs: `checkmark.circle.fill` with `success`, `exclamationmark.triangle.fill` with `warning`, `xmark.octagon.fill` with `danger`.
- The glyphs drawn in these previews are simple stand-ins for SF Symbols (which can't be embedded on the web); in the app, always use the real symbol.
- No logo is defined yet. Until one is supplied, set the app name in `ios-headline` / `mac-headline` and do not draw a mark.

## Using Lumen in SwiftUI

Lumen ships as the Swift package `LumenDesign` (iOS 26+, macOS 26+). Its colours, spacing, radii and sizes are generated from this system's `tokens.json`.

1. Add the package to the app target, then `import LumenDesign`.
2. Call `.lumenTheme()` once at the root of each `WindowGroup`; it applies `accent` as the tint everywhere below.
3. Set the project's `AccentColor` asset to the `accent` values so widgets and system UI outside SwiftUI match.
4. Use the tokens by name: `Color.Lumen.labelSecondary`, `Lumen.Space.s4`, `Lumen.Radius.l`, `Font.Lumen.title3`. Use SwiftUI's own components the Lumen way (`.glassProminent`, `.glass`, `.insetGrouped`) and Lumen's additions where the system has no equivalent: `.buttonStyle(.lumenBordered)`, `.lumenCard()`, `.lumenNumericDisplay()`, `LumenStatusLabel`, `LumenSettingsIcon`.
5. Where a system colour is identical, either is fine: `bg` = `Color(.systemBackground)`, `bg-grouped` = `Color(.systemGroupedBackground)`, `surface` = `Color(.secondarySystemGroupedBackground)`, `label` = `.primary`. Always use the Lumen colour for `label-secondary`, `accent-text`, `accent-soft` and the statuses, which differ on purpose.

A screen in Lumen:

```swift
struct LibraryView: View {
    @State private var query = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Recently Added") {
                    ForEach(items) { item in
                        LabeledContent(item.title, value: item.date.formatted(.relative(presentation: .named)))
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Library")
            .searchable(text: $query)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") { }
                }
            }
        }
        .lumenTheme()
    }
}
```
