//
//  CharacterListResponseModel.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 16/10/25.
//

struct CharacterListResponseModel: Codable {
    let info: Info
    let results: [CharacterEntity]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
