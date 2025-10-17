//
//  Constants.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 16/10/25.
//
import Foundation

enum Constants {
    static let rickMortyApiBaseUrl: String = "https://rickandmortyapi.com/api/"
    static let rickMortyApiTimeoutInterval: Double = 15.0
    static let loading = "Cargando..."
    
    enum Endpoints {
        static let characterList = "character"
        
        static func getCharactersURL(page: Int? = nil, name: String? = nil) -> URL? {
            var components = URLComponents(string: rickMortyApiBaseUrl + characterList)
            var queryItems: [URLQueryItem] = []
            
            if let page = page {
                queryItems.append(URLQueryItem(name: QueryItems.page, value: String(page)))
            }
            
            if let name = name {
                queryItems.append(URLQueryItem(name: QueryItems.name, value: name))
            }
            
            components?.queryItems = queryItems.isEmpty ? nil : queryItems
            
            return components?.url
        }
    }
    
    enum QueryItems {
        static let page = "page"
        static let name = "name"
    }
    
    enum Character {
        static let statusAlive = "alive"
        static let statusDead = "dead"
    }
}
