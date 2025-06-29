//
//  WeatherProviderProtocol.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation

protocol WeatherProviderProtocol {

    func fetchCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async throws -> String
}

final class WeatherProvider: WeatherProviderProtocol {

    private let webService: WebServiceProtocol
    private let remoteConfigProvider: RemoteConfigProtocol

    init(
        webService: WebServiceProtocol,
        remoteConfigProvider: RemoteConfigProtocol
    ) {
        self.webService = webService
        self.remoteConfigProvider = remoteConfigProvider
    }

    func fetchCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async throws -> String {
        let apiKey: String = remoteConfigProvider.getString(for: .apiKey)
        let response: OpenWeatherResponse = try await webService.fetch(
            from: URLBuilderFactory.temperature(
                latitude: latitude,
                longitude: longitude,
                apiKey: apiKey
            )
        )

        let temperature: Int = .init(round(response.main.temp))
        return "\(temperature) °C"
    }
}
