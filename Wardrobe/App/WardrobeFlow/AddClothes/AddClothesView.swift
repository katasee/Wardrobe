//
//  AddClothesView.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI
import PhotosUI

struct AddClothesView: View {

    @State private var viewModel: AddClothesViewModel

    init(viewModel: AddClothesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            backButton
                .padding(.top, 24)
                .padding(.leading, 15)
            header
                .padding(.leading, 15)
            form
        }
        .background(Color.hex011B32.ignoresSafeArea())
        .alert(item: $viewModel.state.error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private var backButton: some View {
        Button {
            viewModel.dismiss()
        } label: {
            Text("Back")
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
        Text("Add Clothes")
            .font(.montserrat(27, .semiBold))
            .foregroundStyle(.white)
    }

    private var form: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 53) {
                VStack(spacing: 16) {
                    categoryPicker
                    VStack(spacing: 10) {
                        clothesTypeTextField
                        brandTypeTextField
                        colorPicker
                        sliderView
                    }
                }
                VStack(spacing: 15) {
                    photoPicker
                    saveButton
                }
            }
            .padding()
            .onChange(of: viewModel.state.imageSelection) { newItem in
                Task {
                    await viewModel.handleImageSelection(newItem)
                }
            }
        }
    }

    private var brandTypeTextField: some View {
        TextFieldView(
            model: .init(
                title: "Brand",
                prompt: "Example: D&B",
                text: $viewModel.state.brand
            )
        )
    }

    private var clothesTypeTextField: some View {
        TextFieldView(
            model: .init(
                title: "Title of clothing",
                prompt: "Example: Jacket",
                text: $viewModel.state.type
            )
        )
    }

    private var colorPicker: some View {
        ColorPickerView(selectedColor: $viewModel.state.color)
    }

    private var categoryPicker: some View {
        CategoryPicker(selected: $viewModel.state.selectedCategory)
    }

    private var saveButton: some View {
        Button {
            viewModel.save()
        } label: {
            Text("SAVE")
                .foregroundStyle(.white)
                .font(.montserrat(22, .medium))
        }
        .disabled(!viewModel.state.isValid)
        .frame(maxWidth: 200)
        .frame(height: 33)
        .background(viewModel.state.isValid ? Color.hexC6A102 : Color.gray)
        .cornerRadius(8)
        .foregroundColor(.hexF4F6FF)
    }

    private var sliderView: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Level")
                    .font(.montserrat(15, .medium))
                    .foregroundStyle(Color.hex1988F3)
                    .padding(.horizontal, 8)
                Slider(
                    value: Binding(
                        get: {
                            Double(viewModel.state.level)
                        },
                        set: {
                            viewModel.state.level = Int($0)
                        }
                    ),
                    in: 0...4,
                    step: 1
                )

                HStack {
                    Image.palmIcon
                    Spacer()
                    Image.sunCloudyIcon
                    Spacer()
                    Image.snowflakeIcon
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("0 - the level of clothing that is suitable in very hot weather")
                    .font(.montserrat(12, .regular))
                Text("4 - the level of clothing that is suitable in very cold weather")
                    .font(.montserrat(12, .regular))
            }
            .foregroundStyle(Color.white)
            .multilineTextAlignment(.leading)
        }
    }

    private var photoPicker: some View {
        PhotosPicker(selection: $viewModel.state.imageSelection, matching: .images) {
            Group {
                if let image = viewModel.state.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Color.hexD9D9D9)
                        .cornerRadius(5)
                        .overlay(Image.cameraIcon)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 192)
        }
    }
}
