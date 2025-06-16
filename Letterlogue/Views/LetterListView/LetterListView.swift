//
//  LetterListView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI
import SwiftData

extension Letter {
    func matchesSearch(_ text: String) -> Bool {
        text.isEmpty ||
        title.localizedCaseInsensitiveContains(text) ||
        content.localizedCaseInsensitiveContains(text)
    }
}

struct LetterListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Letter.timestamp, order: .reverse)])
    var lettersFromDB: [Letter]
    
    @State private var searchText: String = ""
    @State private var path = NavigationPath()
    
    var sortedLetters: [Letter] {
        lettersFromDB
            .filter { $0.matchesSearch(searchText) }
            .sorted {
                if $0.isPinned == $1.isPinned {
                    return $0.timestamp > $1.timestamp
                }
                return $0.isPinned && !$1.isPinned
            }
    }
    
    var pinnedLetters: [Letter] {
        sortedLetters.filter {  $0.isPinned }
    }
    
    var unpinnedLetters: [Letter] {
        sortedLetters.filter {  !$0.isPinned }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                // PINNED Section
                if !pinnedLetters.isEmpty {
                    Section("📌 PINNED") {
                        ForEach(pinnedLetters) { letter in
                            NavigationLink(value: letter) {
                                LetterRow(letter: letter)
                            }
                            .accessibilityIdentifier("letterRow_\(letter.id)")
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    letter.isPinned.toggle()
                                } label: {
                                    Label("Unpin", systemImage: "pin.slash.fill")
                                }
                                .tint(.gray)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deletePinnedLetters)
                    }
                }
                
                // UNPINNED Section
                if !unpinnedLetters.isEmpty {
                    Section("📨 LETTERS") {
                        ForEach(unpinnedLetters) { letter in
                            NavigationLink(value: letter) {
                                LetterRow(letter: letter )
                            }
                            .accessibilityIdentifier("letterRow_\(letter.id)")
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    letter.isPinned.toggle()
                                } label: {
                                    Label("Pin", systemImage: "pin.fill")
                                }
                                .tint(.orange)
                            }
                            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteUnpinnedLetters)
                    }
                }
                
                // Empty state
                let emptyStateText = searchText.isEmpty
                ? "No letters yet. Write today!"
                : "No letters match \"\(searchText)\""
                
                if pinnedLetters.isEmpty && unpinnedLetters.isEmpty {
                    Text(emptyStateText)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                }
            }
            .accessibilityIdentifier("letterList")
            .listStyle(.plain)
            .navigationTitle("💌 All letters")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addNewLetter()
                    } label: {
                        Image("icon-composing-letter")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .accessibilityIdentifier("addLetterButton")
                }
            }
            .navigationDestination(for: Letter.self) { letter in
                LetterDetailView(letter: letter)
            }
        }
    }
    
    // --- Action Methods ---
    private func addNewLetter() {
        let newLetter = Letter(title: "", content: "")
        path.append(newLetter)
    }
    
    private func delete(letters: [Letter], atOffsets offsets: IndexSet) {
        for index in offsets {
            let letterToDelete = letters[index]
            modelContext.delete(letterToDelete)
        }
    }
    
    private func deletePinnedLetters(atOffsets offsets: IndexSet) {
        delete(letters: pinnedLetters, atOffsets: offsets)
    }
    
    private func deleteUnpinnedLetters(atOffsets offsets: IndexSet) {
        delete(letters: unpinnedLetters, atOffsets: offsets)
    }
}

#Preview {
    LetterListView()
}
