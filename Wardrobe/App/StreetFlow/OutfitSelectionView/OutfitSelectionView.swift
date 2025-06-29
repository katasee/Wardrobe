//
//  OutfitSelectionView.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI

struct OutfitSelectionView: View {

    @State private var viewModel: OutfitSelectionViewModel

    private let onDismiss: () -> Void

    init(
        viewModel: OutfitSelectionViewModel,
        onDismiss: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.onDismiss = onDismiss
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 34) {
            VStack(alignment: .leading, spacing: 12) {
                navigationButtons
                header
            }

            optionsList
        }
        .padding(.horizontal, 16)
        .background(Color.hex011B32.ignoresSafeArea())
        .sheet(item: $viewModel.state.showingPickerForCategory) { category in
            ClothingPickerModalView(
                category: category,
                selectedItem: viewModel.state.selectedItems[category],
                items: viewModel.loadClothes(for: category),
                onSelect: { item in
                    viewModel.selectItem(item, for: category)
                    viewModel.state.showingPickerForCategory = nil
                }
            )
            .presentationDetents([.medium])
        }
        .alert(item: $viewModel.state.error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private var navigationButtons: some View {
        HStack {
            navigationButton(
                title: "Back",
                action: onDismiss
            )
            Spacer()
            navigationButton(title: "Save") {
                viewModel.save()
                onDismiss()
            }
        }
    }

    private func navigationButton(
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.montserrat(15, .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.black)
                )
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Outfit Selection")
                .font(.montserrat(27, .semiBold))

            Text(viewModel.timeOfDay.rawValue.capitalized)
                .font(.montserrat(21, .medium))
        }
        .foregroundStyle(.white)
    }

    private var optionsList: some View {
        ScrollView {
            LazyVStack(spacing: 30) {
                ForEach(ClothingCategory.allCases, id: \.self) { category in
                    categorySection(for: category)
                }
            }
        }
    }

    private func categorySection(for category: ClothingCategory) -> some View {
        VStack(spacing: .zero) {
            toggleRow(for: category)

            if viewModel.state.toggledCategories.contains(category) {
                categoryContent(for: category)
            }
        }
        .padding()
        .background(Color.hexC6A102)
        .cornerRadius(7)
    }

    private func toggleRow(for category: ClothingCategory) -> some View {
        HStack {
            Text(category.rawValue.capitalized)
                .font(.montserrat(19, .medium))
                .foregroundStyle(.white)

            Spacer()

            Toggle("", isOn: Binding(
                get: { viewModel.state.toggledCategories.contains(category) },
                set: { viewModel.toggleCategory(category, enabled: $0) }
            ))
            .labelsHidden()
            .toggleStyle(
                CustomToggleStyle(
                    onColor: .hex36323B,
                    offColor: .hex36323B,
                    thumbColor: .hexA7CFFC
                )
            )
        }
    }

    @ViewBuilder
    private func categoryContent(for category: ClothingCategory) -> some View {
        let items: Array<ClothingItem> = viewModel.loadClothes(for: category)

        if items.isEmpty {
            Text("No clothes in this category")
                .font(.montserrat(16, .medium))
                .foregroundStyle(.white)
                .padding()
        } else {
            let selectedItem: ClothingItem? = viewModel.state.selectedItems[category]

            Button {
                viewModel.state.showingPickerForCategory = category
            } label: {
                HStack(spacing: 9) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(selectedItem?.type ?? "")
                            .font(.montserrat(16, .medium))
                        Text(selectedItem?.brand ?? "")
                            .font(.montserrat(12, .light))
                    }
                    .foregroundStyle(.white)

                    Spacer()

                    Rectangle()
                        .fill(Color(hex: selectedItem?.colorHex ?? ""))
                        .frame(width: 20, height: 20)

                    VStack(spacing: 17) {
                        Image.thinChevronUpIcon
                        Image.thinChevronDownIcon
                    }
                }
                .padding(.leading, 36)
                .padding(.trailing, 8)
                .frame(height: 55)
                .background(Color.black.opacity(0.5))
            }
            .padding(.top, 14)
        }
    }
}

