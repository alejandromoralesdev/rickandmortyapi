import SwiftUI

struct LocationDetailView: View {
    @StateObject private var viewModel: LocationDetailViewModel
    
    @State private var selectedCharacter: String?
    
    public init(
        locationId: Int?,
        location: LocationEntity?
    ) {
        self._viewModel = StateObject(
            wrappedValue: LocationDetailViewModel(
                locationId: locationId,
                location: location
            )
        )
    }

    var body: some View {
        VStack(spacing: 16) {
            LocationHeaderView(location: viewModel.location)
                .padding(.horizontal)
                .padding(.top)
            
            Text(L10n.Common.characters)
                .font(.title2)
                .bold()

            CharactersVerticalSectionView(
                characters: viewModel.location?.residents ?? [],
                cardSize: Constants.Sizes.cardCharactersSize,
                spacing: Constants.Sizes.episodesSpacing
            ) { chId in
                selectedCharacter = chId
            }
            .padding(.top, 8)

            Spacer(minLength: 16)
        }
        .padding(.bottom)
        .task {
            await viewModel.loadLocation()
        }
        .navigationTitle(viewModel.location?.name ?? L10n.Locations.unknownName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedCharacter) { character in
            CharacterDetailView(character: nil, characterId: Int(character))
        }
    }
}
