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

#Preview("Add Letter") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true) // Use in-memory for previews
        let container = try ModelContainer(for: Letter.self, configurations: config)
        let exampleLetter = Letter(title: "Preview Title", content: "Preview content.", isPinned: false)
        container.mainContext.insert(exampleLetter) // Insert into the preview's context
        
        return NavigationStack { // So navigation bar items show
            LetterDetailView(letter: exampleLetter)
        }
        .modelContainer(container) // Provide the container to the preview
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

#Preview("Edit Letter") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Letter.self, configurations: config)
        // For a "new" letter, we can create one but not insert it immediately,
        // or insert an empty one that the DetailView will populate.
        // Let's create one that DetailView will bind to.
        let newLetter = Letter() // Will be inserted by LetterListView if user navigates to it
        // For previewing DetailView in isolation with a "new" one:
        // container.mainContext.insert(newLetter) // Optional: insert if you want it in context for preview
        
        return NavigationStack {
            LetterDetailView(letter: newLetter) // Pass a fresh instance
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
