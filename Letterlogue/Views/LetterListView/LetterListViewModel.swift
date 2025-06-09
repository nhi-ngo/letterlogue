//
//  LetterListViewModel.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

@Observable
class LetterListViewModel {
    var letters: [Letter] = []
    var searchText: String = ""
    
    var filteredLetters: [Letter] {
        return letters.sorted(by: { $0.timestamp > $1.timestamp} )
    }
    
    init() {
        letters = MockData.letters
    }
    
    func addLetter(_ letter: Letter) {
        letters.append(letter)
    }
    
    func updateLetter(_ letter: Letter) {
        if let index = letters.firstIndex(where: { $0.id == letter.id }) {
            letters[index] = letter
        }
    }
    
    func deleteLetter(atOffsets offsets: IndexSet) {
        let idsToDelete = offsets.map { filteredLetters[$0].id }
        
        letters.removeAll { letterInOriginal in
            idsToDelete.contains(letterInOriginal.id)
        }
    }
}

