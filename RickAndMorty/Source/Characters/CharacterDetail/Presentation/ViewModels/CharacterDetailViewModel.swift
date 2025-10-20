//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 17/10/25.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: CharacterEntity
    
    public init(character: CharacterEntity) {
        self.character = character
    }
}
