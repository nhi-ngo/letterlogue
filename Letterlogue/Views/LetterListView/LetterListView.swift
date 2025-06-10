//
//  LetterListView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterListView: View {
    
    @State var listViewModel = LetterListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if !listViewModel.pinnedLetters.isEmpty {
                    PinnedLettersSection(listViewModel: listViewModel)
                }
                
                if !listViewModel.unpinnedLetters.isEmpty {
                    UnpinnedLettersSection(listViewModel: listViewModel)
                }
                
                if listViewModel.pinnedLetters.isEmpty && listViewModel.unpinnedLetters.isEmpty {
                    Text("No letters yet. Tap '+' to create one!")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("All letters")
            .searchable(text: $listViewModel.searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        LetterDetailView(
                            listViewModel: listViewModel,
                            detailViewModel: LetterDetailViewModel()
                        )
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    LetterListView()
}


struct PinnedLettersSection: View {
    var listViewModel: LetterListViewModel
    
    var body: some View {
        Section {
            ForEach(listViewModel.pinnedLetters) { letter in
                NavigationLink {
                    LetterDetailView(
                        listViewModel: listViewModel,
                        detailViewModel: LetterDetailViewModel(letter: letter)
                    )
                } label: {
                    LetterRow(letter: letter)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        listViewModel.togglePin(for: letter)
                    } label: {
                        Label("Unpin", systemImage: "pin.slash.fill")
                    }
                    .tint(.gray)
                }
            }
            .onDelete { offsets in
                listViewModel.deleteLetters(atOffsets: offsets, pinned: true)
            }
        } header: {
            Text("PINNED").font(.title2)
        }
    }
}

struct UnpinnedLettersSection: View {
    var listViewModel: LetterListViewModel
    
    var body: some View {
        Section {
            ForEach(listViewModel.unpinnedLetters) { letter in
                NavigationLink {
                    LetterDetailView(
                        listViewModel: listViewModel,
                        detailViewModel: LetterDetailViewModel(letter: letter)
                    )
                } label: {
                    LetterRow(letter: letter)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        listViewModel.togglePin(for: letter)
                    } label: {
                        Label("Pin", systemImage: "pin.fill")
                    }
                    .tint(.orange)
                }
            }
            .onDelete { offsets in
                listViewModel.deleteLetters(atOffsets: offsets, pinned: false)
            }
        } header: {
            Text("OTHERS").font(.title2)
        }
    }
}
