//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ahmet Faruk Arvas on 29.02.2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
