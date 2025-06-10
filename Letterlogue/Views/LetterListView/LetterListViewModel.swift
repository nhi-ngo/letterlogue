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
    
    private var searchedLetters: [Letter] {
        if searchText.isEmpty {
            return letters
        } else {
            return letters.filter { letter in
                let titleMatch =  letter.title.localizedCaseInsensitiveContains(searchText)
                let contentMatch = letter.content.localizedCaseInsensitiveContains(searchText)
                return titleMatch || contentMatch
            }
        }
    }
    
    var pinnedLetters: [Letter] {
        return searchedLetters
            .filter { $0.isPinned }
            .sorted { $0.timestamp > $1.timestamp }
    }
    
    var unpinnedLetters: [Letter] {
        return searchedLetters
            .filter { !$0.isPinned }
            .sorted { $0.timestamp > $1.timestamp }
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
    
    func deleteLetters(atOffsets offsets: IndexSet, pinned: Bool) {
        let source = pinned ? pinnedLetters : unpinnedLetters
        let idsToDelete = offsets.map { source[$0].id }
        letters.removeAll { idsToDelete.contains($0.id) }
    }
    
    func togglePin(for letter: Letter) {
        if let index = letters.firstIndex(where: { $0.id == letter.id }) {
            letters[index].isPinned.toggle()
        }
    }
}

