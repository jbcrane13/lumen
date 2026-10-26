# Toolbar

Toolbar items float on glass above content: grouped capsules for related actions, circles for single ones, a large title that collapses into the inline title on scroll.

## When to use

- Every navigable screen. Primary action trailing, back/close leading, a segmented control or title in the principal slot.

## SwiftUI

```swift
NavigationStack {
    ContentView()
        .navigationTitle("Library")
        .navigationSubtitle("1,204 items")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                ShareLink(item: url)
                Menu("More", systemImage: "ellipsis") { moreActions }
            }
            ToolbarSpacer(.fixed, placement: .primaryAction)
            ToolbarItem(placement: .primaryAction) {
                Button("Add", systemImage: "plus") { add() }
            }
        }
}
```

## The consumer provides

- Actions as `Button("Title", systemImage:)` so they render as icons with an accessible title; `Menu` for overflow; a title in title case.

## Do and don't

- Do group related actions in one `ToolbarItemGroup`; separate unrelated groups with `ToolbarSpacer`.
- Do let items that need the tint (Done, Add) be the only tinted ones: `.buttonStyle(.glassProminent)` on a confirming action in sheets.
- Don't add custom backgrounds behind the toolbar; the scroll edge effect handles legibility.
