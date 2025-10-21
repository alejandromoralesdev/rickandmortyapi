import SwiftUI

struct EpisodesHorizontalSectionView: View {
    let episodes: [String?]
    let cardSize: CGSize
    let spacing: CGFloat
    var onEpisodeTap: ((String) -> Void)? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(L10n.Common.episodes)
                    .font(.title2)
                    .bold()
                Spacer()
                Text("\(validEpisodes.count)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)

            if validEpisodes.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 6) {
                        Image(systemName: "film")
                            .font(.system(size: 28))
                            .foregroundColor(.secondary)
                        Text("L10n.Episode.noEpisodes")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .frame(height: cardSize.height)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: spacing) {
                        ForEach(Array(validEpisodes.enumerated()), id: \.offset) { index, ep in
                            Button(action: {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                onEpisodeTap?(ep)
                            }) {
                                EpisodeCardView(numberText: ep, size: min(cardSize.width, cardSize.height))
                                    .frame(width: cardSize.width, height: cardSize.height)
                            }
                            .buttonStyle(.plain)
                            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .accessibilityLabel(Text("String(format: L10n.Episode.accessibilityLabel, ep)"))
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: cardSize.height)
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    private var validEpisodes: [String] {
        episodes.compactMap { $0 }.map { epString in
            let trimmed = epString.trimmingCharacters(in: .whitespacesAndNewlines)
            if let url = URL(string: trimmed), !url.lastPathComponent.isEmpty {
                return url.lastPathComponent
            }
            return trimmed
        }
    }
}
