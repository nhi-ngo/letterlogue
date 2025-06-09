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
                ForEach(listViewModel.filteredLetters) { letter in
                    NavigationLink {
                        LetterDetailView(
                            listViewModel: listViewModel,
                            detailViewModel: LetterDetailViewModel(letter: letter)
                        )
                    } label: {
                        LetterRow(letter: letter)
                    }
                }
                .onDelete(perform: listViewModel.deleteLetter)
            }
            .listStyle(.plain)
            .navigationTitle("All letters")
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


