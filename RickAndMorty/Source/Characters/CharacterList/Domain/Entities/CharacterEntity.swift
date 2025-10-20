//
//  Character.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 16/10/25.
//

struct CharacterEntity: Identifiable, Codable, Hashable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: LocationEntity?
    let location: LocationEntity?
    let image: String?
    let episode: [String?]
    let url: String?
    let created: String?
}
