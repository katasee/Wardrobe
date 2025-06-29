//
//  TabBarViewModel.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI
import Foundation
import CoreLocation

@Observable
final class TabBarViewModel {

    struct State {

        var selectedTab: TabBarComponentView.TabBarItem = .street
    }

    var state: State

    init(state: State = .init()) {
        self.state = state
    }
}
