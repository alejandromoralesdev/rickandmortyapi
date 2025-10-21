
import Foundation

protocol CharacterDetailDataSourceProtocol {
    func fetchCharacter(id: Int) async throws -> CharacterEntity
}

class CharacterDetailDataSource: CharacterDetailDataSourceProtocol {
    func fetchCharacter(id: Int) async throws -> CharacterEntity {
        guard let url: URL = Constants.Endpoints.getCharacterURL(id: id) else {
            throw URLError(.badURL)
        }

        return try await NetworkUtils.shared.fetch(from: url)
    }
}
