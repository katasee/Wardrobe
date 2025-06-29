//
//  CustomToggleStyle.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {

    private var onColor: Color
    private var offColor: Color
    private var thumbColor: Color

    init(
        onColor: Color,
        offColor: Color,
        thumbColor: Color
    ) {
        self.onColor = onColor
        self.offColor = offColor
        self.thumbColor = thumbColor
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
                .font(.body)
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(
                            RadialGradient(
                                gradient: Gradient(colors: [Color.hex333C9B,
                                                            .hexA7D9FC]),
                                center: .center,
                                startRadius: 0,
                                endRadius: 100
                            ),
                            lineWidth: 3
                        )
                )
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .padding(4)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
