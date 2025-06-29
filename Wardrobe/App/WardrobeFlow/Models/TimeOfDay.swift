//
//  TimeOfDay.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import Foundation

enum TimeOfDay: String,
                Codable,
                CaseIterable,
                Identifiable {

    case morning
    case afternoon
    case evening
    case night

    var id: UUID {
        .init()
    }
}
