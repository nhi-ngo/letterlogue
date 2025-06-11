//
//  LetterDetailView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI
import SwiftData

struct LetterDetailView: View {
    
    @Bindable var letter: Letter
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private enum Field: Hashable {
        case title
        case content
    }
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            TextField("Title", text: $letter.title)
                .font(.title2)
                .focused($focusedField, equals: .title)
            
            TextEditor(text: $letter.content)
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
            let hasContent = !letter.title.isEmpty || !letter.content.isEmpty
            if hasContent {
                modelContext.insert(letter)
            } else {
                modelContext.delete(letter)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LetterDetailView(letter: Letter(title: "Preview Title", content: "Preview content.", isPinned: false))
    }
}
