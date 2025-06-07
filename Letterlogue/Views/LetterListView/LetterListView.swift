//
//  LetterListView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterListView: View {
    
    @State var listViewModel = LetterListViewModel()
    @State private var showingAddLetterSheet = false
    
    var body: some View {
        NavigationStack{
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddLetterSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddLetterSheet) {
                LetterDetailView(
                    listViewModel: listViewModel,
                    detailViewModel: LetterDetailViewModel()
                )
            }
        }
    }
}

#Preview {
    LetterListView()
}


