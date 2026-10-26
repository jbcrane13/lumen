# TabBar

The floating Liquid Glass tab bar for top-level navigation on iPhone, with search as a separate glass circle; it becomes a sidebar on iPad and Mac.

## When to use

- Apps with three to five peer top-level sections. Fewer than three: use a single NavigationStack. More than five: move extras into a sidebar section or the profile screen.

## SwiftUI

```swift
TabView(selection: $tab) {
    Tab("Home", systemImage: "house", value: .home) { HomeView() }
    Tab("Library", systemImage: "square.stack", value: .library) { LibraryView() }
    Tab("Activity", systemImage: "bell", value: .activity) { ActivityView() }
        .badge(unreadCount)
    Tab("Profile", systemImage: "person", value: .profile) { ProfileView() }
    Tab(value: .search, role: .search) { SearchView() }
}
.tabViewStyle(.sidebarAdaptable)          // sidebar on iPad and Mac
.tabBarMinimizeBehavior(.onScrollDown)    // shrinks while reading
.tint(Color.Lumen.accent)
```

## The consumer provides

- Title-case one-word labels, outline SF Symbols (the selected tab switches to `.fill` automatically), and the views.
- Optional `.tabViewBottomAccessory { }` for a persistent mini player or status above the bar.

## Do and don't

- Do let content scroll under the bar; don't add a background behind it.
- Do keep the selected glyph in `accent-text` via `.tint`; leave unselected ones `label`.
- Don't hide the tab bar on pushed screens unless the screen is immersive (a photo viewer, a composer).
