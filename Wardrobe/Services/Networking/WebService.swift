//
//  WebServiceProtocol.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation

protocol WebServiceProtocol {

    func fetch<T: Decodable>(from builder: URLBuilder) async throws -> T
}

final class WebService: WebServiceProtocol {

    func fetch<T: Decodable>(from builder: URLBuilder) async throws -> T {
        let url: URL = try builder.build()
        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(from: url)
        guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingError.invalidStatusCode(httpResponse.statusCode)
        }

        do {
            let decoder: JSONDecoder = .init()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.invalidData
        }
    }
}
