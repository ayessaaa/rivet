//
//  RivetApp.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI

@main
struct RivetApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
                
        } label: {
            Label("Rivet", systemImage: "pawprint.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
