import SwiftUI

struct EpisodesHorizontalSectionView: View {
    let episodes: [String]?
    let cardSize: CGSize
    let spacing: CGFloat
    var onEpisodeTap: ((String) -> Void)? = nil

    private var validEpisodes: [String] { Utils.validIds(episodes) }
    private var cardMinSize: CGFloat { min(cardSize.width, cardSize.height) }

    var body: some View {
        VStack(spacing: 10) {
            header
            content
        }
        .padding(.vertical, 4)
    }

    private var header: some View {
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
    }

    @ViewBuilder
    private var content: some View {
        if validEpisodes.isEmpty {
            VStack(spacing: 6) {
                Image.Errors.noEpisodes
                    .font(.system(size: 28))
                Text(L10n.Episodes.unknownEpisode)
                    .font(.caption)
            }
            .foregroundColor(.secondary)
            .frame(height: cardSize.height)
            .frame(maxWidth: .infinity)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(validEpisodes, id: \.self) { ep in
                        episodeButton(for: ep)
                    }
                }
                .padding(.horizontal)
                .frame(height: cardSize.height)
            }
        }
    }

    private func episodeButton(for ep: String) -> some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            onEpisodeTap?(ep)
        } label: {
            CharacterEpisodeCardView(numberText: ep, size: cardMinSize)
                .frame(width: cardSize.width, height: cardSize.height)
        }
        .buttonStyle(.plain)
        .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.vertical, 4)
    }
}
