//
//  WardrobeView.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftData
import SwiftUI

struct WardrobeView: View {

    @State private var viewModel: WardrobeViewModel

    init(viewModel: WardrobeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: .zero
        ) {
            header
                .padding(.leading, 16)
            wardrobeList
                .padding(.top, 16)
        }
        .onAppear {
            viewModel.loadWardrobe()
        }
        .overlay(alignment: .bottomTrailing) {
            addButton
                .padding(.trailing, 29)
                .padding(.bottom, 25)
        }
        .fullScreenCover(isPresented: $viewModel.state.isPresentingAdd) {
            AddClothesView(
                viewModel: .init(
                    repository: viewModel.repository,
                    dismiss: {
                        viewModel.state.isPresentingAdd = false
                        viewModel.loadWardrobe()
                    }
                )
            )
        }
        .alert(item: $viewModel.state.error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private var header: some View {
        Text("Wardrobe")
            .font(.montserrat(27, .semiBold))
            .padding(.top)
    }

    private var wardrobeList: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                if viewModel.state.groupedItems.isEmpty {
                    emptyState
                } else {
                    ForEach(ClothingCategory.allCases) { category in
                        if let items: Array<ClothingItem> = viewModel.state.groupedItems[category],
                           !items.isEmpty {
                            categorySection(
                                for: category,
                                items: items
                            )
                        }
                    }
                    .padding()
                }
            }
        }
    }

    private func categorySection(
        for category: ClothingCategory,
        items: Array<ClothingItem>
    ) -> some View {
        VStack(alignment: .leading, spacing: 11) {
            Text(category.rawValue)
                .font(.montserrat(19, .medium))
                .foregroundStyle(.white)
                .padding(.leading, 5)

            ForEach(items) { item in
                WardrobeItemRow(item: item)
            }
        }
    }

    private var addButton: some View {
        Button {
            viewModel.state.isPresentingAdd.toggle()
        } label: {
            Image.plusIcon
        }
        .frame(width: 50, height: 50)
        .background(Color.hexF7CC10)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 1)
        )
        .shadow(radius: 4)
    }

    private var emptyState: some View {
        HStack {
            Spacer()
            Text("No items in your wardrobe yet")
                .font(.montserrat(19, .medium))
                .foregroundStyle(.white)
            Spacer()
        }
    }
}

private struct WardrobeItemRow: View {

    let item: ClothingItem

    var body: some View {
        HStack(spacing: 6) {
            VStack(alignment: .leading, spacing: 9) {
                Text(item.type)
                    .font(.montserrat(16, .medium))
                Text(item.brand)
                    .font(.montserrat(12, .light))
            }
            .padding(.leading, 46)

            Spacer()

            Rectangle()
                .fill(Color(hex: item.colorHex))
                .frame(width: 28, height: 29)
                .padding(.trailing, 36)
        }
        .frame(height: 55)
        .background(Color.hexC6A102.opacity(0.5))
        .cornerRadius(8)
    }
}
