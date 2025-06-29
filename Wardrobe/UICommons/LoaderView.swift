//
//  LoaderModifier.swift
//  Wardrobe
//
//  Created by Anton on 29/06/2025.
//

import SwiftUI

struct LoaderModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 2 : 0)

            if isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
        }
    }
}

extension View {
    func loader(_ isLoading: Bool) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
