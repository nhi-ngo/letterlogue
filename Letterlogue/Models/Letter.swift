//
//  Letter.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import Foundation

struct Letter: Identifiable, Codable {
    var id = UUID()
    var title: String = ""
    var content: String
    var timestamp: Date = Date()
}

struct MockData {
    static let letters = [
        Letter(title: "Welcome!", content: "This is your first letter in Letterlogue.", timestamp: Date().addingTimeInterval(-86400 * 2)),
        Letter(title: "Shopping List", content: "Milk, Bread, Eggs", timestamp: Date().addingTimeInterval(-86400)),
        Letter(title: "Ideas for Project X", content: "Brainstorming session notes...", timestamp: Date())
    ]
}
