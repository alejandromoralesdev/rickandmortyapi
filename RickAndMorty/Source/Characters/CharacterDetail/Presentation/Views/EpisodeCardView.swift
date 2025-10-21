import SwiftUI

struct EpisodeCardView: View {
    let numberText: String
    let size: CGFloat

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(backgroundGradient)
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.12 : 0.06),
                        radius: 8, x: 0, y: 4)

            Text(numberText)
                .font(.system(size: size * 0.48, weight: .black, design: .rounded))
                .foregroundColor(Color.Main.episodeCardText)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .allowsHitTesting(false)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement()
        .accessibilityLabel(Text("String(format: L10n.Episode.accessibilityLabel, numberText)"))
    }

    // MARK: - Helpers
    private var accentColor: Color {
        colorScheme == .dark ? .yellow : .blue
    }

    private var backgroundGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(colors: [Color.blue.opacity(0.20), Color.purple.opacity(0.14)], startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(colors: [Color.blue.opacity(0.96), Color.purple.opacity(0.86)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
