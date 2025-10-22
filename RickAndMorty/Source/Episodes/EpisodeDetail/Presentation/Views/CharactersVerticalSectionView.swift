import SwiftUI

struct CharactersVerticalSectionView: View {
    let characters: [String]?
    let cardSize: CGFloat
    let spacing: CGFloat
    var onCharacterTap: ((String) -> Void)? = nil

    private var rows: [GridItem] {
        [GridItem(.fixed(cardSize))]
    }

    var body: some View {
        VStack(spacing: 8) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: Constants.Sizes.imageWidth), spacing: spacing)], spacing: spacing) {
                    ForEach(Utils.validCharacters(characters), id: \.self) { character in
                        
                        Button(action: {
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            onCharacterTap?(character)
                        }) {
                            CharacterEpisodeSectionCardView(character: character, width: nil, height: Constants.Sizes.rowHeight)
                                .frame(minHeight: Constants.Sizes.rowHeight)
                        }
                        .buttonStyle(.plain)
                        .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.vertical, 4)
                    }
                }
            }
            
        }
        .padding(.horizontal, 0)
    }
}
