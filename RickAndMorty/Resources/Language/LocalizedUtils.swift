import SwiftUI

extension LocalizedStringKey {
	public var stringKey: String {
        let description = "\(self)"

        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }

        return components[1][0]
    }
}

extension String {
    public static func localizedString(
		for key: String,
		in tableName: String,
		locale: Locale = .current,
		bundle: Bundle
    ) -> String {
		let localizedString = NSLocalizedString(key, tableName: tableName, bundle: bundle, comment: "")

        return localizedString
    }

	public func replaceLocalized(id: String, value: String) -> String {
        return self.replacingOccurrences(of: "·\(id)·", with: value)
    }

	public func replaceMarkdown() -> String {
        return self.replacingOccurrences(of: "·", with: "**")
    }

	public func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: self)
    }

    public func localize(in tableName: String, bundle: Bundle) -> String {
        LocalizedStringKey(self).stringValue(in: tableName, bundle: bundle)
    }
}
extension LocalizedStringKey {
	public func stringValue(
		locale: Locale = .current,
		in tableName: String,
		bundle: Bundle
	) -> String {
		return .localizedString(
			for: self.stringKey,
			in: tableName,
			locale: locale,
			bundle: bundle
		)
    }

	public func localizedUppercase(
		locale: Locale = .current,
		in tableName: String,
		bundle: Bundle
	) -> String {
		return .localizedString(
			for: self.stringKey,
			in: tableName,
			locale: locale,
			bundle: bundle
		).uppercased()
    }

	public func localizedCapitalize(
		locale: Locale = .current,
		in tableName: String,
		bundle: Bundle
	) -> String {
		return .localizedString(
			for: self.stringKey,
			in: tableName,
			locale: locale,
			bundle: bundle
		).capitalized
    }
}
