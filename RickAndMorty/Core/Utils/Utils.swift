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
    
    public static func accentColor(colorScheme: ColorScheme ) -> Color {
        colorScheme == .dark ? .yellow : .blue
    }

    public static func backgroundGradient(colorScheme: ColorScheme) -> LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(colors: [Color.blue.opacity(0.20), Color.purple.opacity(0.14)], startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(colors: [Color.blue.opacity(0.96), Color.purple.opacity(0.86)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    public static func validIds(_ ids: [String]?) -> [String] {
        guard let ids else { return [] }
        
        return ids.compactMap { $0 }.map { chString in
            if let url = URL(string: chString), !url.lastPathComponent.isEmpty {
                return url.lastPathComponent
            }
            return chString.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
