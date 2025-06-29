//
//  TabBarView.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI
import SwiftData

struct TabBarView: View {

    @State private var viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if viewModel.state.selectedTab == .street {
                StreetView(
                    viewModel: .init(
                        wardrobeRepository: AppContext.shared.wardrobeRepository,
                        locationProvider: LocationProvider(),
                        weatherProvider: WeatherProvider(
                            webService: WebService(),
                            remoteConfigProvider: AppContext.shared.remoteConfigProvider
                        )
                    )
                )
            } else {
                WardrobeView(
                    viewModel: WardrobeViewModel(
                        repository: AppContext.shared.wardrobeRepository
                    )
                )
            }

            TabBarComponentView(selectedTabItem: $viewModel.state.selectedTab)
        }
        .background(Color.hex011B32.ignoresSafeArea())
    }
}
