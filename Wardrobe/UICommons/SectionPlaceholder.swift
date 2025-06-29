//
//  SectionPlaceholder.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import SwiftUI

struct SectionPlaceholder: View {

    var body: some View {
        ZStack {
            VStack(spacing: 11) {
                Image.hangerIcon
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)

                Text("Pick Outfit")
                    .font(.montserrat(20, .medium))

            }
            .foregroundStyle(Color.white)

            Rectangle()
                .fill(Color.hexF7CC10.opacity(0.4))
                .frame(height: 152)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.hexF7CC10, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 7))
        }
    }
}

#Preview {
    ZStack() {
        Color.hex011B32.ignoresSafeArea()
        SectionPlaceholder()
    }
}
