import Foundation
import SwiftUI

public enum L10n {
    
    internal static let tableName = "Localizable"
    
    public enum Common {
        /// Loading Characters
        public static let loadingCharacters: String = "loading_characters".localize(in: tableName, bundle: .main)
        /// NAvigation Title
        public static let mainTitle: String = "main_title".localize(in: tableName, bundle: .main)
    }
}
