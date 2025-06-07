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
    
    init() {
        self.letter = Letter(content: "")
        self.title = ""
        self.content = ""
        self.originalLetter = nil
    }
    
    init(letter: Letter) {
        self.letter = letter
        self.title = letter.title
        self.content = letter.content
        self.originalLetter = letter
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
