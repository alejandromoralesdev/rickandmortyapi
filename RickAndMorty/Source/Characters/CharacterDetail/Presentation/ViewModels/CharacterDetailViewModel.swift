import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: CharacterEntity?
    @Published var characterId: Int?
    @Published var isLoadingPage: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    private var getCharacterDetailUseCase: GetCharacterDetailUseCase
    
    public init(
        character: CharacterEntity? = nil,
        characterId: Int? = nil,
        getCharacterDetailUseCase: GetCharacterDetailUseCase = GetCharacterDetailUseCase()
    ) {
        self.character = character
        self.characterId = characterId
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
    }
    
    @MainActor
    func loadCharacterDetail() async {
        if character != nil { return }
        guard let characterId else { return }
        isLoadingPage = true
        errorMessage = nil
        
        await fetchCharacterDetail(id: characterId)
        isLoadingPage = false
    }
    
    @MainActor
    private func fetchCharacterDetail(id: Int) async {
        do {
            character = try await getCharacterDetailUseCase.execute(id: id)
            
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
