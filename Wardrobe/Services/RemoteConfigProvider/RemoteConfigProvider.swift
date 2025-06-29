//
//  RemoteConfigProtocol.swift
//  Wardrobe
//
//  Created by Anton on 29/06/2025.
//

import FirebaseRemoteConfig

protocol RemoteConfigProtocol {

    func fetchRemoteConfig() async -> Bool
    func getString(for key: RemoteConfigKey) -> String
}

final class RemoteConfigProvider: RemoteConfigProtocol {

    private let remoteConfig: RemoteConfig

    init(remoteConfig: RemoteConfig) {
        self.remoteConfig = remoteConfig
        let settings: RemoteConfigSettings = .init()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }

    @discardableResult
    func fetchRemoteConfig() async -> Bool {
        await withCheckedContinuation { continuation in
            remoteConfig.fetchAndActivate { status, error in
                if error != nil {
                    continuation.resume(returning: false)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }

    func getString(for key: RemoteConfigKey) -> String {
        remoteConfig.configValue(forKey: key.rawValue).stringValue
    }
}
