# Sidebar

The Mac and iPad sidebar: a floating Liquid Glass panel inset from the window edge, with section headers, SF Symbol rows and an `accent-soft` selection.

## When to use

- Mac apps and regular-width iPad layouts with a source list (libraries, folders, projects). Two columns for most apps, three when a list sits between sidebar and detail.

## SwiftUI

```swift
NavigationSplitView {
    List(selection: $selection) {
        Section("Library") {
            Label("Recents", systemImage: "clock").badge(24)
            Label("Documents", systemImage: "doc")
            Label("Favorites", systemImage: "star").badge(8)
        }
        Section("Projects") {
            ForEach(projects) { Label($0.name, systemImage: "folder") }
        }
    }
    .navigationSplitViewColumnWidth(min: 180, ideal: 210)
} detail: {
    DetailView(selection: selection)
        .backgroundExtensionEffect()   // let hero images reach under the sidebar
}
.tint(Color.Lumen.accent)
```

## The consumer provides

- Sections with sentence-case headers, rows as `Label` (title + SF Symbol), optional `.badge` counts, and a selection binding.

## Do and don't

- Do use `mac-body` (13pt) rows, `hit-mac` (28pt) tall, symbols tinted with the accent.
- Do let the detail's background extend under the sidebar instead of painting a divider.
- Don't put more than about two levels of disclosure in a sidebar; deeper hierarchies belong in the detail column.
