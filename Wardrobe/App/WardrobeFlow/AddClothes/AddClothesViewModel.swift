//
//  AddClothesViewModel.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI
import PhotosUI

@Observable
final class AddClothesViewModel {

    let dismiss: () -> Void
    private let repository: WardrobeRepositoryProtocol

    struct State {

        var selectedImageData: Data?
        var selectedImage: UIImage?
        var imageSelection: PhotosPickerItem?

        var selectedCategory: ClothingCategory? = nil
        var type: String = ""
        var brand: String = ""
        var color: Color = .red
        var level: Int = 2

        var isValid: Bool {
            selectedCategory != nil &&
            !type.isEmpty &&
            !brand.isEmpty
        }
        var error: AppError?
    }

    var state: State

    init(
        repository: WardrobeRepositoryProtocol,
        dismiss: @escaping () -> Void,
        state: State = .init()
    ) {
        self.repository = repository
        self.dismiss = dismiss
        self.state = state
    }

    func save() {
        guard let category: ClothingCategory = state.selectedCategory else {
            return
        }

        let item: ClothingItem = .init(
            type: state.type,
            brand: state.brand,
            colorHex: state.color.toHex() ?? "#000000",
            imageData: state.selectedImageData,
            suitability: WeatherSuitability.fromLevel(state.level),
            category: category
        )

        do {
            try repository.add(item: item)
            dismiss()
        } catch {
            state.error = AppError(message: "Failed to save item \(error)")
        }
    }

    func handleImageSelection(_ item: PhotosPickerItem?) async {
        guard let item: PhotosPickerItem else {
            return
        }

        do {
            if let data: Data = try await item.loadTransferable(type: Data.self),
               let original: UIImage = .init(data: data),
               let result: (
                resized: UIImage,
                data: Data
               ) = original.resizedAndCompressed() {
                state.selectedImage = result.resized
                state.selectedImageData = result.data
            }
        } catch {
            state.error = AppError(message: "Failed to load or compress image: \(error)")
        }
    }
}
