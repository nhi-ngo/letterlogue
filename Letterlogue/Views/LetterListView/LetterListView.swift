//
//  LetterListView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI
import SwiftData

struct LetterListView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Letter.timestamp, order: .reverse)])
    var lettersFromDB: [Letter]
    
    var sortedLetters: [Letter] {
        lettersFromDB.sorted {
            if $0.isPinned == $1.isPinned {
                return $0.timestamp > $1.timestamp
            }
            return $0.isPinned && !$1.isPinned
        }
    }
    
    @State private var searchText: String = ""
    @State private var path = NavigationPath()
    
    var pinnedLetters: [Letter] {
        lettersFromDB.filter { letter in
            letter.isPinned && (searchText.isEmpty ||
                                letter.title.localizedCaseInsensitiveContains(searchText) ||
                                letter.content.localizedCaseInsensitiveContains(searchText))
        }
    }
    
    var unpinnedLetters: [Letter] {
        lettersFromDB.filter { letter in
            !letter.isPinned && (searchText.isEmpty ||
                                 letter.title.localizedCaseInsensitiveContains(searchText) ||
                                 letter.content.localizedCaseInsensitiveContains(searchText))
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                // PINNED Section
                if !pinnedLetters.isEmpty {
                    Section("PINNED") {
                        ForEach(pinnedLetters) { letter in
                            NavigationLink(value: letter) {
                                LetterRow(letter: letter)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    letter.isPinned.toggle()
                                } label: {
                                    Label("Unpin", systemImage: "pin.slash.fill")
                                }
                                .tint(.gray)
                            }
                        }
                        .onDelete(perform: deletePinnedLetters)
                    }
                }
                
                // OTHERS Section
                if !unpinnedLetters.isEmpty {
                    Section("LETTERS") {
                        ForEach(unpinnedLetters) { letter in
                            NavigationLink(value: letter) {
                                LetterRow(letter: letter )
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    letter.isPinned.toggle()
                                } label: {
                                    Label("Pin", systemImage: "pin.fill")
                                }
                                .tint(.orange)
                            }
                        }
                        .onDelete(perform: deleteUnpinnedLetters)
                    }
                }
                
                // Empty state
                let emptyStateText = searchText.isEmpty
                    ? "No letters yet. Tap '+' to add one!"
                    : "No letters match \"\(searchText)\""
                
                if pinnedLetters.isEmpty && unpinnedLetters.isEmpty {
                    Text(emptyStateText)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("All letters")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addNewLetter()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .navigationDestination(for: Letter.self) { letter in
                LetterDetailView(letter: letter)
            }
            .onAppear {
                for letter in lettersFromDB {
                    print("📨 \(letter.title) | \(letter.timestamp) | Pinned: \(letter.isPinned)")
                }
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
