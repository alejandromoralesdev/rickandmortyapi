//
//  GetCharacterListUseCase.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 16/10/25.
//

import Foundation

class GetCharacterListUseCase {
    let repository: CharacterListRepositoryProtocol

    init(characterRepository: CharacterListRepositoryProtocol = CharacterListRepository()) {
        self.repository = characterRepository
    }

    func execute(page: Int? = nil, name: String? = nil) async throws -> CharacterListResponseModel {
        return try await repository.fetchCharacters(page: page, name: name)
    }
}
