//
//  Colors.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 20/10/25.
//

import SwiftUI

// swiftlint:disable nesting
extension Color {
    public static let main: Color = Color("colorExample", bundle: .main)
    
    public static var random: Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    
    public enum Main: CaseIterable {
        public static let background = Color("background", bundle: .main)
        public static let backgroundCard = Color("backgroundCard", bundle: .main)
        public static let backgroundEpisode = Color("backgroundEpisode", bundle: .main)
        public static let episodeCardText = Color("episodeCardText", bundle: .main)
    }
}
// swiftlint:enable nesting
