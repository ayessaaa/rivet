//
//  RivetApp.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI
import SwiftData

@main
struct RivetApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
                .modelContainer(for: Streak.self)
        } label: {
            Label("Rivet", systemImage: "pawprint.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
