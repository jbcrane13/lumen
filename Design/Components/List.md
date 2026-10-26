# List

The inset-grouped list: opaque `surface` sections with `radius-l` corners on `bg-grouped`, rows at least 44pt tall, hairline separators inset to the text.

## When to use

- Settings, account screens, detail screens with labelled values, any vertical set of tappable rows.
- Use `.plain` lists on `bg` for long homogeneous feeds (messages, files).

## SwiftUI

```swift
List {
    Section {
        NavigationLink { ProfileView() } label: {
            Label {
                Text("Profile")
                Text("Name, photo, email")
            } icon: {
                SettingsIcon("person.fill")
            }
        }
        NavigationLink(value: Route.sync) {
            LabeledContent("Sync", value: "On")
        }
    } header: {
        Text("Account")
    } footer: {
        Text("Signed in as \(email)")
    }

    Section {
        Button("Sign Out", role: .destructive) { signOut() }
    }
}
.listStyle(.insetGrouped)

struct SettingsIcon: View {
    let name: String
    init(_ name: String) { self.name = name }
    var body: some View {
        Image(systemName: name)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 30, height: 30)
            .background(Color.Lumen.accent, in: .rect(cornerRadius: 8, style: .continuous))
    }
}
```

## The consumer provides

- Rows (title in `.body`, optional subtitle in `label-secondary`, optional trailing value), section headers in sentence case, footers that explain effects.

## Do and don't

- Do let the system draw chevrons, separators and the pressed state (`fill-tertiary`).
- Do use `LabeledContent` for value rows so VoiceOver reads label and value together.
- Do keep icon tiles in `accent` with white glyphs; other colours fail contrast in Dark.
- Don't put glass on list sections, and don't add shadows to them.
