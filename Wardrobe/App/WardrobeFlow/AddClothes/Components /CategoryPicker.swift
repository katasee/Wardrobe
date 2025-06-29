//
//  CategoryPicker.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI

struct CategoryPicker: View {

    @Binding var selected: ClothingCategory?
    @State private var isOpen: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerButton

            if isOpen {
                categoryList
                    .padding(.bottom, 16)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.leading, 16)
        .frame(maxWidth: 200)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.hexC6A102)
        )
    }

    private var headerButton: some View {
        Button {
            withAnimation(.easeInOut) {
                isOpen.toggle()
            }
        } label: {
            HStack {
                Text(selected?.rawValue ?? "Category")
                    .font(.montserrat(16, .medium))
                    .foregroundColor(.white)
                Spacer()
                chevronIcon
            }
        }
        .frame(height: 33)
    }

    private var chevronIcon: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 42)
                .cornerRadius(7)
            Image.chevronDownIcon
                .rotationEffect(.degrees(isOpen ? 180 : 0))
                .animation(.easeInOut, value: isOpen)
        }
    }

    private var categoryList: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(ClothingCategory.allCases) { category in
                Button {
                    withAnimation(.easeInOut) {
                        selected = category
                        isOpen = false
                    }
                } label: {
                    Text(category.rawValue)
                        .font(.montserrat(16, .medium))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
