//
//  WardrobeApp.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct WardrobeApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: .init())
        }
    }
}
