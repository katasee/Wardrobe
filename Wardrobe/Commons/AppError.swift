//
//  AppError.swift
//  Wardrobe
//
//  Created by Anton on 29/06/2025.
//

import Foundation

struct AppError: Identifiable, Error {

    let id: UUID = .init()
    let message: String
}
