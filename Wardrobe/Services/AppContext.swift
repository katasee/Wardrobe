//
//  AppContext.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI
import SwiftData

@MainActor
final class AppContext {

    static let shared: AppContext = .init()

    let container: ModelContainer
    let wardrobeRepository: WardrobeRepositoryProtocol
    let remoteConfigProvider: RemoteConfigProtocol

    private init() {
        container = try! ModelContainer(
            for: ClothingItem.self,
            OutfitSelection.self,
            OutfitItem.self
        )
        wardrobeRepository = DefaultWardrobeRepository(context: container.mainContext)
        remoteConfigProvider = RemoteConfigProvider(remoteConfig: .remoteConfig())
    }

    func fetchRemoteConfig() {
        Task {
           await remoteConfigProvider.fetchRemoteConfig()
        }
    }
}
