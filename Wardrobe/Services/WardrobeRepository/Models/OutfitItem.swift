//
//  OutfitItem.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import Foundation
import SwiftData

@Model
final class OutfitItem {

    @Attribute(.unique)
    var id: UUID
    var clothingItem: ClothingItem?
    var outfitId: UUID

    init(
        clothingItem: ClothingItem,
        outfitId: UUID
    ) {
        self.id = .init()
        self.clothingItem = clothingItem
        self.outfitId = outfitId
    }
}
