import Foundation

protocol CharacterListRepositoryProtocol {
    func fetchCharacters(page: Int?, name: String?) async throws -> CharacterListResponseModel
}
