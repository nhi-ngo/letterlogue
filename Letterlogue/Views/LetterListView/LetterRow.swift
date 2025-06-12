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
            Text(letter.title.isEmpty ? "Untitled" : letter.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(letter.timestamp, style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(letter.content)
                .font(.caption)
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                .foregroundColor(.gray.opacity(0.5))
        )
    }
}

#Preview {
    NavigationStack {
        List {
            NavigationLink(value: "test1") {
                LetterRow(letter: Letter(title: "Tyyuhgr", content: "Some content here", timestamp: Date(), isPinned: false))
            }
            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .listRowSeparator(.hidden)
            
            NavigationLink(value: "test2") {
                LetterRow(letter: Letter(title: "Another Letter", content: "More details", timestamp: Date().addingTimeInterval(-86400), isPinned: true))
            }
            .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("LETTERS")
    }
}
