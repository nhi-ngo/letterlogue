//
//  LetterDetailViewModel.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

@Observable
class LetterDetailViewModel {
    var letter: Letter
    var title: String
    var content: String
    
    private var originalLetter: Letter?
    var isNew: Bool { originalLetter == nil }
    
    var hasChanges: Bool {
        if let original = originalLetter {
            return title != original.title || content != original.content
        }
        return false
    }
    
    // For new letter
    init() {
        self.letter = Letter(content: "")
        self.title = ""
        self.content = ""
        self.originalLetter = nil
    }
    
    // For editing existing letter
    init(letter: Letter) {
        self.originalLetter = letter
        self.letter = letter
        self.title = letter.title
        self.content = letter.content
    }
    
    func saveLetter() -> Letter {
        var letterToSave: Letter
        if let original = originalLetter {
            letterToSave = original
        } else {
            letterToSave = self.letter
        }
        
        letterToSave.title = self.title
        letterToSave.content = self.content
        letterToSave.timestamp = Date()
        
        return letterToSave
    }
}
