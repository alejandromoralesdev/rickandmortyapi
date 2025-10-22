import SwiftUI

struct LocationCardView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let location: LocationEntity
    let size: CGFloat
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Utils.backgroundGradient(colorScheme: colorScheme))
                    .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.12 : 0.06),
                            radius: 8, x: 0, y: 4)
                
                Text("\(location.id)")
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
                Text(location.name ?? L10n.Locations.unknownName)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                HStack(spacing: 8) {
                    Text(location.type ?? L10n.Locations.unknownType)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("-")
                        .foregroundColor(.secondary)
                    Text(location.dimension ?? L10n.Locations.unknownDimension)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(L10n.Locations.residents)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(Utils.validIds(location.residents), id: \.self) { character in
                                
                                AsyncImage(url: Constants.Endpoints.getImageURL(id: character)) { phase in
                                    Group {
                                        switch phase {
                                        case .empty:
                                            ZStack {
                                                Color(white: 0.95)
                                                ProgressView()
                                            }
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        case .failure:
                                            ZStack {
                                                Color(white: 0.95)
                                                Image.Errors.noPhoto
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundColor(.gray)
                                                    .padding(40 * 0.1)
                                            }
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 40, height: 40)
                                    .background(Color.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    .compositingGroup()
                                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                                }
                            }
                        }
                    }
                }
                .padding(.trailing, 5)
                
                
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
