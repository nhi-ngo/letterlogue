//
//  LetterListView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterListView: View {
    
    @State var viewModel = LetterListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredLetters) { letter in
                    NavigationLink {
                        LetterDetailView(letter: letter)
                    } label: {
                        LetterRow(letter: letter)
                    }
                }
            }
            .navigationTitle("All letters")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print()
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

struct LetterRow: View {
    var letter: Letter
    
    var body: some View {
        Text(letter.title)
    }
}
