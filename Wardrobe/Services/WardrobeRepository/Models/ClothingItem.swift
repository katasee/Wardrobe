//
//  ClothingItem.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import Foundation
import SwiftData
import UIKit.UIImage

@Model
final class ClothingItem: Identifiable {

    @Attribute(.unique) var id: UUID
    var type: String
    var brand: String
    var colorHex: String
    var imageData: Data?
    var suitability: WeatherSuitability
    var category: ClothingCategory

    init(
        id: UUID = .init(),
        type: String,
        brand: String,
        colorHex: String,
        imageData: Data? = nil,
        suitability: WeatherSuitability,
        category: ClothingCategory
    ) {
        self.id = id
        self.type = type
        self.brand = brand
        self.colorHex = colorHex
        self.imageData = imageData
        self.suitability = suitability
        self.category = category
    }
}

extension Array<ClothingItem> {

    func mapToOutfitCategoryItems() -> Array<OutfitCategoryItem> {
        self.map {
            OutfitCategoryItem(
                image: $0.imageData.flatMap(UIImage.init(data:)),
                title: $0.category.rawValue.capitalized
            )
        }
    }
}
