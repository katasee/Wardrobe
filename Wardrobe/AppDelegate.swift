//
//  WardrobeApp.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Firebase
import SwiftUI

final class AppDelegate: NSObject,
                         UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: Dictionary<UIApplication.LaunchOptionsKey, Any>? = nil
    ) -> Bool {
        FirebaseApp.configure()
        AppContext.shared.fetchRemoteConfig()
        return true
    }
}
