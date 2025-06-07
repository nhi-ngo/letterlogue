//
//  LetterRow.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI

struct LetterRow: View {
    var letter: Letter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(letter.title.isEmpty ? "Untitled" : letter.title).font(.headline)
            Text(letter.timestamp, style: .date).font(.subheadline).foregroundColor(.gray)
            Text(letter.content)
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    LetterRow(letter: MockData.letters[0])
}
