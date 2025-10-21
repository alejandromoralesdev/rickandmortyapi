import SwiftUI

extension Image {
    public enum CharacterDetail {
        public static let copy = Image("doc.on.doc", bundle: .main)
        public static let safari = Image("safari", bundle: .main)
    }
    
    public enum Errors {
        public static let noPhoto = Image("photo", bundle: .main)
    }
}
