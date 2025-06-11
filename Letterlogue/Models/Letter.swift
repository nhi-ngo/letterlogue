//
//  Letter.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import Foundation
import SwiftData

@Model
class Letter {
    var id: UUID
    var title: String
    var content: String
    var timestamp: Date
    var isPinned: Bool
    
    init(id: UUID = UUID(),
         title: String = "",
         content: String = "",
         timestamp: Date = Date(),
         isPinned: Bool = false) {
        self.id = id
        self.title = title
        self.content = content
        self.timestamp = timestamp
        self.isPinned = isPinned
    }
}
