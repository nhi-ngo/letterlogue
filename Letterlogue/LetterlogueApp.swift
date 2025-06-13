//
//  LetterlogueApp.swift
//  Letterlogue
//
//  Created by Nhi Ngo on 6/6/25.
//

import SwiftUI
import SwiftData

@main
struct LetterlogueApp: App {
    var body: some Scene {
        WindowGroup {
            LetterListView()
        }
        .modelContainer(for: Letter.self)
    }
}
