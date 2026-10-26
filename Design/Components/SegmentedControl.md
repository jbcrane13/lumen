# SegmentedControl

A capsule picker for switching between two to five views of the same content.

## When to use

- Switching a view's mode or time scale (Day / Week / Month / Year, List / Grid).
- Not for navigation between unrelated screens (use the tab bar) and not for settings with more than five options (use a menu picker).

## SwiftUI

```swift
Picker("Range", selection: $range) {
    ForEach(Range.allCases) { Text($0.title).tag($0) }
}
.pickerStyle(.segmented)
.fixedSize()                 // hug content in toolbars
```

## The consumer provides

- A selection binding and short title-case labels (one word each), or SF Symbols with labels for icon segments.

## Do and don't

- Do keep labels equally short so segments stay even.
- Do place it in the toolbar (`ToolbarItem(placement: .principal)`) when it changes the whole screen.
- Don't mix icons and text across segments.
