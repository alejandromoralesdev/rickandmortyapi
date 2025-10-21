
class CharacterListRepository: CharacterListRepositoryProtocol {

    private let characterListDataSource: CharacterListDataSourceProtocol
    
    init(characterListDataSource: CharacterListDataSourceProtocol = CharacterListDataSource()) {
        self.characterListDataSource = characterListDataSource
    }

    func fetchCharacters(page: Int? = nil, name: String? = nil) async throws -> CharacterListResponseModel {
        let characterListResponse: CharacterListResponseModel = try await characterListDataSource.fetchCharacters(page: page, name: name)

        return characterListResponse
    }
}
