import SwiftUI

extension Image {
    public enum InitialScreen {
        public static let allCharacters = Image(systemName: "person.3")
        public static let allEpisodes = Image(systemName: "film.stack")
    }
    public enum CharacterDetail {
        public static let copy = Image(systemName: "doc.on.doc")
        public static let safari = Image(systemName: "safari")
    }
    
    public enum Buttons {
        public static let rightIcon = Image(systemName: "chevron.right")
    }
    
    public enum Errors {
        public static let noPhoto = Image(systemName: "photo")
        public static let noEpisodes = Image(systemName: "film")
    }
}
