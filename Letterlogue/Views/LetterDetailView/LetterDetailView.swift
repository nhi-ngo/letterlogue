//
//  LetterDetailView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterDetailView: View {
    
    var listViewModel: LetterListViewModel
    @State var detailViewModel = LetterDetailViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $detailViewModel.title)
                    .font(.title2)
                    .padding()
                
                TextEditor(text: $detailViewModel.content)
                    .frame(maxHeight: .infinity)
                    .border(Color.gray.opacity(0.2), width: 1)
                    .padding(.horizontal)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        let savedLetter = detailViewModel.saveLetter()
                        if detailViewModel.isNew {
                            listViewModel.addLetter(savedLetter)
                        } else {
                            listViewModel.updateLetter(savedLetter)
                        }
                        dismiss()
                    }
                    .disabled(detailViewModel.content.isEmpty && detailViewModel.title.isEmpty)
                }
            }
        }
    }
}

#Preview("Add Letter") {
    NavigationStack {
        LetterDetailView(
            listViewModel: LetterListViewModel(),
            detailViewModel: LetterDetailViewModel())
    }
}

#Preview("Edit Letter") {
    NavigationStack {
        LetterDetailView(
            listViewModel: LetterListViewModel(),
            detailViewModel: LetterDetailViewModel(letter: MockData.letters[0]))
    }
}
