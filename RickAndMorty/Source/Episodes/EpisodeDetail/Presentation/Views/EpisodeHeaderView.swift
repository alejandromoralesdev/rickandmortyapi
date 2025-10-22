import SwiftUI

struct EpisodeHeaderView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let episode: EpisodeEntity?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(LinearGradient(
                    colors: gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .opacity(0.08)
            
            HStack(spacing: 16) {
                avatar
                    .frame(width: Constants.Sizes.imageSize, height: Constants.Sizes.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)

                VStack(alignment: .leading, spacing: 8) {
                    Text(episode?.name ?? L10n.Episodes.unknownEpisode)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    HStack(spacing: 8) {
                        Text(episode?.episode ?? L10n.Episodes.unknownEpisode)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Text(episode?.airDate ?? L10n.Episodes.unknownEpisode)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }

    private var avatar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Utils.backgroundGradient(colorScheme: colorScheme))
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.12 : 0.06),
                        radius: 8, x: 0, y: 4)
            
            Text(String(episode?.id ?? 0))
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
    }

    private var gradientColors: [Color] {
        [Color.accentColor.opacity(0.12), Color.primary.opacity(0.02)]
    }
}
