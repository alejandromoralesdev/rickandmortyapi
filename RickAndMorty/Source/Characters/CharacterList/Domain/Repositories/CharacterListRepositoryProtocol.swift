//
//  CharacterListRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 16/10/25.
//

import Foundation

protocol CharacterListRepositoryProtocol {
    func fetchCharacters(page: Int?, name: String?) async throws -> CharacterListResponseModel
}
