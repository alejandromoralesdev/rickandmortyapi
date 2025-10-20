//
//  Utils.swift
//  RickAndMorty
//
//  Created by Alejandro Morales Cañete on 19/10/25.
//

import Foundation
import SwiftUI

class Utils {
    public static func nonEmpty(_ text: String?) -> String? {
        guard let t = text, !t.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
        return t
    }

    public static func formattedDate(from isoString: String?) -> String? {
        guard let iso = isoString else { return nil }
        if let date = iso8601Date(from: iso) {
            let fmt = DateFormatter()
            fmt.dateStyle = .medium
            fmt.timeStyle = .short
            return fmt.string(from: date)
        }
        return nil
    }

    public static func iso8601Date(from string: String) -> Date? {
        let iso1 = ISO8601DateFormatter()
        iso1.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let d = iso1.date(from: string) { return d }
        iso1.formatOptions = [.withInternetDateTime]
        if let d = iso1.date(from: string) { return d }

        let fallback = DateFormatter()
        fallback.locale = Locale(identifier: "en_US_POSIX")
        fallback.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return fallback.date(from: string)
    }
    
    @ViewBuilder
    public static func statusBadge(for status: String?) -> some View {
        let s = (status ?? "").lowercased()
        let color: Color = {
            if s.contains(Constants.Character.statusAlive) { return .green }
            if s.contains(Constants.Character.statusDead) { return .red }
            return .gray
        }()

        Circle()
            .fill(color)
            .frame(width: 12, height: 12)
            .overlay(Circle().stroke(Color.black.opacity(0.06), lineWidth: 0.5))
            .accessibilityHidden(true)
    }
}
