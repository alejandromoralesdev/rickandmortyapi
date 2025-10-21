import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// All logs related to tracking and analytics.
    static let api = Logger(subsystem: subsystem, category: "API")
}
