//
//  TextFieldModel.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI

struct TextFieldModel {

    var title: String
    var prompt: String
    var text: Binding<String>
}

struct TextFieldView: View {

    private var model: TextFieldModel

    init(model: TextFieldModel) {
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleLabel
                .padding(.leading, 8)
            textField
        }
    }

    private var titleLabel: some View {
        Text(model.title)
            .font(.montserrat(15, .medium))
            .foregroundStyle(Color.hex1988F3)
    }

    private var textField: some View {
        HStack {
            TextField(
                "",
                text: model.text,
                prompt: promptLabel
            )
            .foregroundStyle(Color.white)
            .padding(.leading, 13)
            Spacer(minLength: 8)
            Image.pencilIcon
                .padding(.trailing, 21)
        }
        .font(.montserrat(15, .medium))
        .frame(height: 41)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.hexD9D9D9)
        )
    }

    private var promptLabel: Text {
        Text(model.prompt)
            .foregroundStyle(Color.white)
            .font(.montserrat(12, .light))
    }
}
