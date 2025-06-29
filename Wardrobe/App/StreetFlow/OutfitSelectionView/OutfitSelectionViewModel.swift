//
//  OutfitSelectionViewModel.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation
import SwiftUI

@Observable
final class OutfitSelectionViewModel {

    struct State {

        var showingPickerForCategory: ClothingCategory?
        var isLoading: Bool = false
        var selectedItems: Dictionary<ClothingCategory, ClothingItem> = .init()
        var toggledCategories: Set<ClothingCategory> = []
        var error: AppError?
    }

    var state: State

    let timeOfDay: TimeOfDay
    let date: Date
    let repository: WardrobeRepositoryProtocol

    init(
        timeOfDay: TimeOfDay,
        repository: WardrobeRepositoryProtocol,
        date: Date = .init(),
        state: State = .init()
    ) {
        self.date = date
        self.timeOfDay = timeOfDay
        self.repository = repository
        self.state = state
        loadExistingSelection()
    }

    func loadClothes(for category: ClothingCategory) -> Array<ClothingItem> {
        do {
            return try repository.fetchAll().filter { $0.category == category }
        } catch {
            state.error = AppError(message: "Failed to load clothes")
            return []
        }
    }
    
    private func loadExistingSelection() {
        do {
            if let outfit: OutfitSelection = try repository.getOutfitSelection(
                for: date,
                timeOfDay: timeOfDay
            ) {
                for outfitItem: OutfitItem in outfit.items {
                    if let clothingItem: ClothingItem = outfitItem.clothingItem {
                        state.selectedItems[clothingItem.category] = clothingItem
                        state.toggledCategories.insert(clothingItem.category)
                    }
                }
            }
        } catch {
            state.error = AppError(message: "Failed to load outfit selection: \(error)")
        }
    }

    func toggleCategory(
        _ category: ClothingCategory,
        enabled: Bool
    ) {
        if enabled {
            state.toggledCategories.insert(category)
            // Preselect first item if none selected yet
            if state.selectedItems[category] == nil {
                let items: Array<ClothingItem> = loadClothes(for: category)
                if let first: ClothingItem = items.first {
                    state.selectedItems[category] = first
                }
            }
        } else {
            state.toggledCategories.remove(category)
            state.selectedItems.removeValue(forKey: category)
        }
    }

    func selectItem(
        _ item: ClothingItem,
        for category: ClothingCategory
    ) {
        state.selectedItems[category] = item
    }

    func save() {
        do {
            let items: Array<ClothingItem> = state.toggledCategories.compactMap { state.selectedItems[$0] }
            try repository.saveOutfitSelection(
                date: date,
                timeOfDay: timeOfDay,
                items: items
            )
        } catch {
            state.error = AppError(message: "Failed to save outfit selection")
        }
    }
}

