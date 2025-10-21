import Foundation

protocol CharacterListDataSourceProtocol {
    func fetchCharacters(page: Int?, name: String?) async throws -> CharacterListResponseModel
}

class CharacterListDataSource: CharacterListDataSourceProtocol {
    func fetchCharacters(page: Int? = nil, name: String? = nil) async throws -> CharacterListResponseModel {
        guard let url: URL = Constants.Endpoints.getCharactersURL(page: page, name: name) else {
            throw URLError(.badURL)
        }

        return try await NetworkUtils.shared.fetch(from: url)
    }
}
