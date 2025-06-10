//
//  Letter.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import Foundation

struct Letter: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String = ""
    var content: String
    var timestamp: Date = Date()
    var isPinned: Bool = false
}

struct MockData {
    static let letters = [
        Letter(title: "Important Pinned Task", content: "Must do this today.", timestamp: Date(), isPinned: true),
        Letter(title: "Welcome!", content: "This is your first letter in Letterlogue.", timestamp: Date().addingTimeInterval(-86400 * 2), isPinned: false),
        Letter(title: "Another Pinned Item", content: "Milk, Bread, Eggs", timestamp: Date().addingTimeInterval(-86400), isPinned: true),
        Letter(title: "Ideas for Project X", content: "Brainstorming session notes...", timestamp: Date(), isPinned: false)
    ]
}
