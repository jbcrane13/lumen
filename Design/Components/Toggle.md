# Toggle

A switch for on/off settings that take effect immediately, tinted with the Lumen accent.

## When to use

- Settings rows that apply instantly (Allow Notifications). If the change needs a Save, use a checkbox-style toggle on Mac or a different pattern.
- On Mac inside a Form, the default style is a checkbox; use `.toggleStyle(.switch)` only for a setting that turns a whole feature on or off.

## SwiftUI

```swift
Form {
    Section {
        Toggle(isOn: $allowNotifications) {
            Label("Allow Notifications", systemImage: "bell.fill")
        }
        Toggle(isOn: $quietHours) {
            Text("Quiet Hours")
            Text("10:00 PM – 7:00 AM")      // becomes the subtitle
        }
    } header: {
        Text("Notifications")
    } footer: {
        Text("Quiet Hours silences everything except calls from Favorites.")
    }
}
.tint(Color.Lumen.accent)
```

## The consumer provides

- A `Binding<Bool>`, a title-case label, an optional second `Text` as subtitle, and a footer when the effect isn't obvious.

## Do and don't

- Do describe the on state in the label ("Allow Notifications", not "Notifications Off").
- Do disable dependent rows (`.disabled(!allowNotifications)`) rather than hiding them.
- Don't restyle the switch; the system draws the Liquid Glass thumb and track. The web preview only approximates it.
