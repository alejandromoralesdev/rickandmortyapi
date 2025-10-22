import SwiftUI

struct EpisodesHorizontalSectionView: View {
    let episodes: [String]?
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
                Text("\(Utils.validIds(episodes).count)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)

            if Utils.validIds(episodes).isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 6) {
                        Image.Errors.noEpisodes
                            .font(.system(size: 28))
                            .foregroundColor(.secondary)
                        Text(L10n.Episodes.unknownEpisode)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .frame(height: cardSize.height)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: spacing) {
                        ForEach(Utils.validIds(episodes), id: \.self) { ep in
                            Button(action: {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                onEpisodeTap?(ep)
                            }) {
                                CharacterEpisodeCardView(numberText: ep, size: min(cardSize.width, cardSize.height))
                                    .frame(width: cardSize.width, height: cardSize.height)
                            }
                            .buttonStyle(.plain)
                            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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
}
