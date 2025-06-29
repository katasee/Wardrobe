//
//  URLBuilderProtocol.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation

protocol URLBuilderProtocol {

    var baseURL: String { get }
    var path: String? { get }
    var queryItems: Array<URLQueryItem> { get }

    func build() throws -> URL
}

struct URLBuilder: URLBuilderProtocol {

    var baseURL: String
    var path: String?
    var queryItems: Array<URLQueryItem> = .init()

    func build() throws -> URL {
        guard var components: URLComponents = .init(string: baseURL) else {
            throw NetworkingError.invalidURL
        }

        if let path: String {
            components.path += path
        }

        components.queryItems = queryItems.isEmpty ? nil : queryItems

        guard let url: URL = components.url else {
            throw NetworkingError.invalidURL
        }

        return url
    }
}
