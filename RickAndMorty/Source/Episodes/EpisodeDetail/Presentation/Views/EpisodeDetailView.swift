import SwiftUI

struct EpisodeDetailView: View {
    @StateObject private var viewModel: EpisodeDetailViewModel
    
    @State private var selectedCharacter: String?
    
    public init(episodeId: Int?, episode: EpisodeEntity?) {
        self._viewModel = StateObject(
            wrappedValue: EpisodeDetailViewModel(
                episodeId: episodeId,
                episode: episode
            )
        )
    }

    var body: some View {
        VStack(spacing: 16) {
            EpisodeHeaderView(episode: viewModel.episode)
            
            Text(L10n.Common.characters)
                .font(.title2)
                .bold()
            
            CharactersVerticalSectionView(
                characters: viewModel.episode?.characters,
                cardSize: Constants.Sizes.cardCharactersSize,
                spacing: Constants.Sizes.episodesSpacing
            ) { chId in
                selectedCharacter = chId
            }
            .padding(.top, 4)
        }
        .task {
            await viewModel.loadEpisode()
        }
        .padding()
        .navigationTitle(viewModel.episode?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedCharacter) { characterId in
            CharacterDetailView(character: nil, characterId: Int(characterId))
        }
    }
}
