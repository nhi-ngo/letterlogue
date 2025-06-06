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
