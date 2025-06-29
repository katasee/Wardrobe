//
//  NetworkingError.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

enum NetworkingError: Error {

    case invalidURL
    case invalidResponse
    case invalidData
    case invalidStatusCode(Int)
}
