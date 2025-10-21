import SwiftUI

struct EpisodeCardView: View {
    @Environment(\.colorScheme) private var colorScheme

    let episode: EpisodeEntity
    let size: CGFloat

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Utils.backgroundGradient(colorScheme: colorScheme))
                    .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.12 : 0.06),
                            radius: 8, x: 0, y: 4)

                Text("\(episode.id)")
                    .font(.system(size: Constants.Sizes.cardEpisodesSize * 0.48, weight: .black, design: .rounded))
                    .foregroundColor(Color.Main.episodeCardText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .allowsHitTesting(false)
            }
            .frame(width: Constants.Sizes.imageWidth, height: Constants.Sizes.rowHeight)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .fixedSize()
            .accessibilityElement()

            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text(episode.name ?? L10n.Character.unknownName)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(episode.episode ?? L10n.Episodes.unknownEpisode)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: 2) {
                    Text(L10n.Episodes.airDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(episode.airDate ?? L10n.Character.unknownName)
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }

                Spacer()
            }
            .frame(height: Constants.Sizes.rowHeight)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.Main.backgroundCard)
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        )
        .padding(.horizontal, 8)
        .frame(height: Constants.Sizes.rowHeight + 20)
        .accessibilityElement(children: .combine)
    }
}
