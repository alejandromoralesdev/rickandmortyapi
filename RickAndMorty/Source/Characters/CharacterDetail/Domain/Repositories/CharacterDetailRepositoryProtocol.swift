import Foundation

protocol CharacterDetailRepositoryProtocol {
    func fetchCharacter(id: Int) async throws -> CharacterEntity
}
