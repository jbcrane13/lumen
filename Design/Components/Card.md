# Card

An opaque content container on `bg-grouped`: `surface`, `radius-l` corners, with inner shapes kept concentric.

## When to use

- Grouping one piece of content with its media and metadata (an album, a stat, a recommendation) in a grid or horizontal scroll.
- Not for settings (use List) and never as glass.

## SwiftUI

```swift
struct AlbumCard: View {
    let album: Album

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            album.cover
                .resizable().scaledToFill()
                .frame(height: 120)
                .clipShape(ConcentricRectangle())          // radius-l − space-2 = radius-m
            VStack(alignment: .leading, spacing: 2) {
                Text(album.title).font(.title3.weight(.semibold))
                Text(album.subtitle).font(.subheadline).foregroundStyle(Color.Lumen.labelSecondary)
            }
            .padding(.horizontal, Lumen.Space.s2)
            .padding(.vertical, Lumen.Space.s3)
        }
        .padding(Lumen.Space.s2)
        .background(Color.Lumen.surface, in: .rect(cornerRadius: Lumen.Radius.l, style: .continuous))
        .containerShape(.rect(cornerRadius: Lumen.Radius.l, style: .continuous))
    }
}

// Stat card
Text(steps, format: .number)
    .font(.system(size: 48, weight: .bold, design: .rounded))
    .monospacedDigit()
    .contentTransition(.numericText())
```

## The consumer provides

- The content (image, title, subtitle or a value), a tap target (`NavigationLink` or `Button`) wrapping the whole card, and an accessibility label combining its text.

## Do and don't

- Do derive inner radii from the outer one: radius-l (24) with `space-2` (8) padding gives radius-m (16).
- Do use `numeric-display` with `.contentTransition(.numericText())` for changing numbers.
- Don't add shadows on iOS; on Mac, `shadow-raised` only on hover.
