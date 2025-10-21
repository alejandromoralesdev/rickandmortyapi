import SwiftUI

struct CharacterEpisodeSectionCardView: View {
    let character: String
    var width: CGFloat? = nil
    var height: CGFloat? = nil

    private var defaultImageWidth: CGFloat { Constants.Sizes.imageWidth }
    private var defaultRowHeight: CGFloat { Constants.Sizes.rowHeight }

    var body: some View {
        let imageCornerRadius: CGFloat = 12
        let cardCornerRadius: CGFloat = 14

        let effectiveWidth = width ?? defaultImageWidth
        let effectiveHeight = height ?? defaultRowHeight

        HStack(spacing: 4) {
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
                                .padding(effectiveWidth * 0.1)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: effectiveWidth, height: effectiveHeight)
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: imageCornerRadius, style: .continuous))
                .compositingGroup()
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
            }
        }
        .frame(height: effectiveHeight)
        .background(
            RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous)
                .fill(Color.Main.backgroundCard)
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: cardCornerRadius, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}
