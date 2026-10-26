# Button

Capsule buttons in four weights: glass prominent for the one primary action, glass for secondary actions on glass, bordered for secondary actions on opaque content, plain for tertiary links.

## When to use

- `.glassProminent` + `.tint(Color.Lumen.accent)`: the single primary action of a screen or sheet (Continue, Done, Create). One per screen.
- `.glass`: secondary actions that float over content (Not Now, toolbar-like circular buttons, a floating Add).
- `.bordered`: secondary actions inside opaque content such as a card or list (Add Photos). Renders `accent-soft` behind `accent-text`.
- `.borderless` / plain: tertiary actions and inline links (Learn More), in `accent-text`.
- `role: .destructive`: Delete, Remove, Sign Out. The system colours it `danger`; never fill it.

## SwiftUI

```swift
Button("Continue") { advance() }
    .buttonStyle(.glassProminent)
    .controlSize(.large)

Button("Not Now") { dismiss() }
    .buttonStyle(.glass)

Button("Add", systemImage: "plus") { add() }
    .buttonStyle(.glass)
    .labelStyle(.iconOnly)
    .buttonBorderShape(.circle)

Button("Delete", systemImage: "trash", role: .destructive) { delete() }
    .buttonStyle(.glass)

// Bottom-pinned primary action
Button { create() } label: {
    Text("Create Account").frame(maxWidth: .infinity)
}
.buttonStyle(.glassProminent)
.controlSize(.large)          // control-large: 50pt
.padding(.horizontal, Lumen.Space.s4)
```

## The consumer provides

- A verb label in title case, two words at most; an SF Symbol for icon-only buttons plus a text label for accessibility (`Button("Share", systemImage:)`, never an `Image` alone).
- The action closure, and `.disabled(_:)` with the condition, rather than hiding the button.

## Do and don't

- Do keep every button at least `hit-ios` (44pt) tall on touch, `hit-mac` (28pt) on Mac. On Mac the default button style takes the tint automatically; set `.keyboardShortcut(.defaultAction)` on the primary.
- Do let the button be a capsule; don't set a custom corner radius.
- Don't put two prominent buttons side by side; demote one to `.glass`.
- Don't tint `.glass` buttons; tint is reserved for the prominent one.
