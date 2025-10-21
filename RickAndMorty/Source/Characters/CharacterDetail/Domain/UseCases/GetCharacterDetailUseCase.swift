import Foundation

class GetCharacterDetailUseCase {
    let repository: CharacterDetailRepositoryProtocol

    init(characterRepository: CharacterDetailRepositoryProtocol = CharacterDetailRepository()) {
        self.repository = characterRepository
    }

    func execute(id: Int) async throws -> CharacterEntity {
        return try await repository.fetchCharacter(id: id)
    }
}
