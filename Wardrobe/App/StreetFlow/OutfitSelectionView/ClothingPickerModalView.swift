//
//  ClothingPickerModalView.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI

struct ClothingPickerModalView: View {

    let category: ClothingCategory
    let selectedItem: ClothingItem?
    let items: Array<ClothingItem>
    let onSelect: (ClothingItem) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 27) {
            title
                .padding(.top, 30)
            list
        }
        .background(Color.hex011B32.ignoresSafeArea())
    }

    private var title: some View {
        Text("OUTERWEAR")
            .font(.montserrat(30, .semiBold))
            .foregroundStyle(.white)
    }

    private var list: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(items) { item in
                    buildRow(
                        item: item,
                        selected: item == selectedItem,
                        onTapAction: {
                            onSelect(item)
                            dismiss()
                        }
                    )
                    .padding(.horizontal, 30)
                }
            }
        }
    }

    private func buildRow(
        item: ClothingItem,
        selected: Bool,
        onTapAction: @escaping () -> Void
    ) -> some View {
        Button {
            onTapAction()
        } label: {
            HStack(spacing: 6) {
                VStack(
                    alignment: .leading,
                    spacing: 9
                ) {
                    Text(item.type)
                        .font(.montserrat(16, .medium))
                    Text(item.brand)
                        .font(.montserrat(12, .light))
                }
                .foregroundStyle(.white)
                .padding(.leading, 46)

                Spacer()

                Rectangle()
                    .fill(Color(hex: item.colorHex))
                    .frame(width: 28, height: 29)

                Group {
                    if selected {
                        Image.checkmarkIcon
                            .resizable()
                            .frame(width: 28, height: 29)
                    } else {
                        Color.clear
                            .frame(width: 28, height: 29)
                    }
                }
                .padding(.trailing, 8)
            }
            .frame(height: 55)
            .background(Color.hexC6A102.opacity(0.8))
            .cornerRadius(8)
        }
    }
}
