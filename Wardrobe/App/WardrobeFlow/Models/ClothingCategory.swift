//
//  ClothingCategory.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import Foundation

enum ClothingCategory: String,
                       Codable,
                       CaseIterable,
                       Identifiable {
    
    case bottoms = "Bottoms"
    case outerwear = "Outerwear"
    case shoes = "Shoes"

    var id: String {
        rawValue
    }
}
