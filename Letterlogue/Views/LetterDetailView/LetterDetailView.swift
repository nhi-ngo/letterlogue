//
//  LetterDetailView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterDetailView: View {
    private enum Field: Hashable {
        case title
        case content
    }
    
    var listViewModel: LetterListViewModel
    @State var detailViewModel = LetterDetailViewModel()
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            TextField("Title", text: $detailViewModel.title)
                .font(.title2)
                .focused($focusedField, equals: .title)
            
            TextEditor(text: $detailViewModel.content)
                .frame(maxHeight: .infinity)
                .border(Color.gray.opacity(0.2), width: 1)
                .focused($focusedField, equals: .content)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    focusedField = nil
                }
            }
        }
        .onDisappear {
            if detailViewModel.isNew {
                if !detailViewModel.title.isEmpty || !detailViewModel.content.isEmpty {
                    let letterToSave = detailViewModel.saveLetter()
                    listViewModel.addLetter(letterToSave)
                }
            } else {
                if detailViewModel.hasChanges {
                    let letterToSave = detailViewModel.saveLetter()
                    listViewModel.updateLetter(letterToSave)
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
