
class CharacterDetailRepository: CharacterDetailRepositoryProtocol {

    private let characterDetailDataSource: CharacterDetailDataSourceProtocol
    
    init(characterDetailDataSource: CharacterDetailDataSourceProtocol = CharacterDetailDataSource()) {
        self.characterDetailDataSource = characterDetailDataSource
    }

    func fetchCharacter(id: Int) async throws -> CharacterEntity {
        let characterDetailResponse: CharacterEntity = try await characterDetailDataSource.fetchCharacter(id: id)

        return characterDetailResponse
    }
}
