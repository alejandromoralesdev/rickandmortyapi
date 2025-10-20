import Foundation
import SwiftUI

public enum L10n {
    
    internal static let tableName = "Localizable"
    
    public enum Common {
        /// Loading Characters
        public static let loadingCharacters: String = "loading_characters".localize(in: tableName, bundle: .main)
        /// Navigation Title
        public static let mainTitle: String = "main_title".localize(in: tableName, bundle: .main)
    }
    
    public enum Character {
        /// Name
        public static let name: String = "name".localize(in: tableName, bundle: .main)
        /// Status
        public static let status: String = "status".localize(in: tableName, bundle: .main)
        /// Specie
        public static let specie: String = "specie".localize(in: tableName, bundle: .main)
        /// Origin
        public static let origin: String = "origin_title".localize(in: tableName, bundle: .main)
        /// Genre
        public static let gender: String = "gender".localize(in: tableName, bundle: .main)
        /// Type
        public static let type: String = "type".localize(in: tableName, bundle: .main)
        /// Last Location
        public static let lastLocation: String = "last_location".localize(in: tableName, bundle: .main)
        /// Created
        public static let created: String = "created".localize(in: tableName, bundle: .main)
        /// URL Label
        public static let urlLabel: String = "urlLabel".localize(in: tableName, bundle: .main)
        /// Character
        public static let character: String = "character".localize(in: tableName, bundle: .main)
        /// Unknown Name
        public static let unknownName: String = "no_name".localize(in: tableName, bundle: .main)
        /// Unknown Location
        public static let unknownLocation: String = "no_location".localize(in: tableName, bundle: .main)
        /// Unknown Specie
        public static let unknownSpecie: String = "no_specie".localize(in: tableName, bundle: .main)
        /// Unknown Gender
        public static let unknownGender: String = "no_gender".localize(in: tableName, bundle: .main)
        /// Unknown Status
        public static let unknownStatus: String = "no_status".localize(in: tableName, bundle: .main)
    }
    
    public enum Errors {
        /// General Error
        public static let general: String = "general_error_message".localize(in: tableName, bundle: .main)
        /// Alert Title
        public static let alertTitle: String = "alert_title".localize(in: tableName, bundle: .main)
        public static let alertButton: String = "alert_button".localize(in: tableName, bundle: .main)
    }
}
