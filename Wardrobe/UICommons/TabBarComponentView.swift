//
//  TabBarComponentView.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI

struct TabBarComponentView: View {

    enum TabBarItem: String,
                     CaseIterable {

        case street = "Street"
        case wardrobe = "Wardrobe"
    }

    @Binding var selectedTabItem: TabBarItem

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBarItem.allCases, id: \.self) { tabItem in
                Button {
                    selectedTabItem = tabItem
                } label: {
                    Text(tabItem.rawValue)
                        .font(.montserrat(24, .regular))
                        .foregroundColor(
                            selectedTabItem == tabItem
                            ? .hex011B32
                            : .hex011B32.opacity(0.5)
                        )
                        .frame(maxWidth: .infinity, minHeight: 86)
                        .background(
                            selectedTabItem == tabItem
                            ? Color.hexF7CC10
                            : .white
                        )
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 23))
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.hex011B32.ignoresSafeArea()
        TabBarComponentView(selectedTabItem: .constant(.street))
    }
}
