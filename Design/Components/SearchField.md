# SearchField

Search via `.searchable`, which on iPhone floats at the bottom of the screen in a glass capsule and on iPad and Mac sits in the toolbar.

## When to use

- Any list or collection someone may need to filter. Attach it to the `NavigationStack` content or to a `Tab(role: .search)` when search is a destination of its own.

## SwiftUI

```swift
NavigationStack {
    List(results) { ItemRow(item: $0) }
        .navigationTitle("Library")
}
.searchable(text: $query, prompt: "Search")
.searchSuggestions {
    ForEach(suggestions) { Text($0.title).searchCompletion($0.title) }
}

// Search as its own tab (gets the separate glass circle in the tab bar)
TabView {
    Tab("Home", systemImage: "house") { HomeView() }
    Tab(role: .search) { SearchView() }
}
```

## The consumer provides

- The text binding, a prompt in title case naming the scope ("Search Settings"), filtered results, and an empty state ("No Results for “Lisbon”").

## Do and don't

- Do use the system field; it brings the glass, the mic, Cancel and keyboard handling.
- Do keep the placeholder in `label-tertiary` (the system does) and never use it as a label.
- Don't build a custom search bar at the top of an iPhone screen; it fights the bottom placement people now expect.
