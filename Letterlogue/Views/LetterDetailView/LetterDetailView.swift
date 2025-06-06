//
//  LetterDetailView.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterDetailView: View {
    
    var letter: Letter
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationTitle(letter.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LetterDetailView(letter: Letter(title: "Welcome!", content: "This is your first letter in Letterlogue.", timestamp: Date().addingTimeInterval(-86400 * 2)))
    }
}
