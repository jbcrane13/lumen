# Sheet

A modal card that slides up from the bottom; at medium height it floats inset from the screen edges on glass, at large height it covers the screen with `radius-xl` corners.

## When to use

- Focused, interruptible tasks: create, edit, filter, share. Use a full-screen cover only for immersive flows.
- On Mac, sheets attach to the window; prefer them for short forms.

## SwiftUI

```swift
.sheet(isPresented: $showNewAlbum) {
    NavigationStack {
        Form {
            TextField("Album Name", text: $name)
            Toggle("Shared Album", isOn: $shared)
        }
        .navigationTitle("New Album")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark", role: .cancel) { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", systemImage: "checkmark", role: .confirm) { save() }
                    .disabled(name.isEmpty)
            }
        }
    }
    .presentationDetents([.medium, .large])
}
```

## The consumer provides

- A title, cancel and confirm actions, content, and the detents it supports. Confirm in the trailing slot, cancel leading.

## Do and don't

- Do keep the sheet's own content opaque (`surface`, nested rows on `surface-raised`); the system supplies the glass at partial height.
- Do use `.interactiveDismissDisabled(hasChanges)` and confirm before discarding edits.
- Don't stack sheets more than one deep.
