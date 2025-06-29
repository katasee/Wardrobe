//
//  OutfitCategoryItem.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI

struct OutfitCategoryItem: Identifiable {

    let id: UUID = .init()
    let image: UIImage?
    let title: String
}

struct OutfitSelectionRow: View {

    private let items: Array<OutfitCategoryItem>

    init(items: Array<OutfitCategoryItem>) {
        self.items = items
    }

    var body: some View {
        HStack(spacing: 10) {
            ForEach(items) { item in
                categoryItemView(item)
            }
            Spacer()
        }
        .padding(.horizontal, 13)
        .frame(maxWidth: .infinity)
        .frame(height: 152)
        .background(backgroundView)
    }

    @ViewBuilder
    private func categoryItemView(_ item: OutfitCategoryItem) -> some View {
        VStack {
            categoryImage(for: item)
            Text(item.title)
                .font(.montserrat(14, .extraLight))
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private func categoryImage(for item: OutfitCategoryItem) -> some View {
        if let image = item.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 89, height: 89)
                .clipped()
                .cornerRadius(2)
        } else {
            ZStack {
                Color.gray.opacity(0.2)
                Image.hangerIcon
                    .resizable()
                    .scaledToFit()
                    .frame(height: 34)
                    .foregroundColor(.gray)
            }
            .frame(width: 89, height: 89)
            .cornerRadius(2)
        }
    }

    private var backgroundView: some View {
        Rectangle()
            .fill(Color.hexF7CC10.opacity(0.4))
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.hexF7CC10, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
