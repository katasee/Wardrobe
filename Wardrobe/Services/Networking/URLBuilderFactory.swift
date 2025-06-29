//
//  URLBuilderFactory.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation

enum URLBuilderFactory {

    static func temperature(
        latitude: Double,
        longitude: Double,
        apiKey: String
    ) -> URLBuilder {
        .init(
            baseURL: Constants.baseURL,
            path: "/weather",
            queryItems: [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
        )
    }
}
