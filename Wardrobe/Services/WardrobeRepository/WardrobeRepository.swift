//
//  WardrobeRepositoryProtocol.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftData
import Foundation

protocol WardrobeRepositoryProtocol {

    func fetchAll() throws -> Array<ClothingItem>
    func fetchGroupedByCategory() throws -> Dictionary<ClothingCategory, Array<ClothingItem>>
    func add(item: ClothingItem) throws
    func delete(item: ClothingItem) throws
    func getOutfitSelection(
        for date: Date,
        timeOfDay: TimeOfDay
    ) throws -> OutfitSelection?
    func saveOutfitSelection(
        date: Date,
        timeOfDay: TimeOfDay,
        items: Array<ClothingItem>
    ) throws
}

final class DefaultWardrobeRepository: WardrobeRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> Array<ClothingItem> {
        try context.fetch(FetchDescriptor<ClothingItem>())
    }

    func fetchGroupedByCategory() throws -> Dictionary<ClothingCategory, Array<ClothingItem>> {
        let allClothingItems: Array<ClothingItem> = try fetchAll()
        return Dictionary(grouping: allClothingItems, by: { $0.category })
    }

    func add(item: ClothingItem) throws {
        context.insert(item)
        try context.save()
    }

    func getOutfitSelection(
        for date: Date,
        timeOfDay: TimeOfDay
    ) throws -> OutfitSelection? {
        let startOfDay: Date = Calendar.current.startOfDay(for: date)

        let descriptor = FetchDescriptor<OutfitSelection>(
            predicate: #Predicate {
                $0.date == startOfDay && $0.timeOfDayRaw == timeOfDay.rawValue
            }
        )

        return try context.fetch(descriptor).first
    }
    
    func saveOutfitSelection(
        date: Date,
        timeOfDay: TimeOfDay,
        items: Array<ClothingItem>
    ) throws {
        let startOfDay: Date = Calendar.current.startOfDay(for: date)

        if let existing: OutfitSelection = try getOutfitSelection(for: startOfDay, timeOfDay: timeOfDay) {
            context.delete(existing)
        }

        let newOutfit: OutfitSelection = .init(
            date: startOfDay,
            timeOfDay: timeOfDay
        )

        newOutfit.items = items.map { item in
            OutfitItem(
                clothingItem: item,
                outfitId: newOutfit.id
            )
        }

        context.insert(newOutfit)
        try context.save()
    }

    func delete(item: ClothingItem) throws {
        context.delete(item)
        try context.save()
    }
}
