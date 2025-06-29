//
//  ColorPickerView.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI

struct ColorPickerView: View {

    @Binding var selectedColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleLabel
                .padding(.leading, 8)
            colorPicker
        }
    }

    private var titleLabel: some View {
        Text("Color")
            .font(.montserrat(15, .medium))
            .foregroundStyle(Color.hex1988F3)
    }

    private var colorPicker: some View {
        ColorPicker("Select Color", selection: $selectedColor)
            .font(.montserrat(15, .medium))
            .padding(.leading, 13)
            .padding(.trailing, 21)
            .frame(height: 41)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.hexD9D9D9)
            )
    }
}
