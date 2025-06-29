//
//  WardrobeViewModel.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation
import Observation

@Observable
final class WardrobeViewModel {

    struct State {

        var isPresentingAdd = false
        var groupedItems: Dictionary<ClothingCategory, Array<ClothingItem>> = .init()
        var error: AppError?
    }

    var state: State

    let repository: WardrobeRepositoryProtocol

    init(
        repository: WardrobeRepositoryProtocol,
        state: State = .init()
    ) {
        self.repository = repository
        self.state = state
    }

    func loadWardrobe() {
        do {
            state.groupedItems = try repository.fetchGroupedByCategory()
        } catch {
            state.error = AppError(message: "Failed to load wardrobe")
        }
    }
}
