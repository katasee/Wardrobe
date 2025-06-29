//
//  OutfitSelection.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import Foundation
import SwiftData

@Model
final class OutfitSelection {

    @Attribute(.unique)
    var id: UUID
    var date: Date
    var timeOfDayRaw: String

    @Relationship(deleteRule: .cascade)
    var items: Array<OutfitItem> = []

    init(
        date: Date,
        timeOfDay: TimeOfDay
    ) {
        self.id = UUID()
        self.date = date
        self.timeOfDayRaw = timeOfDay.rawValue
    }

    var timeOfDay: TimeOfDay? {
        get { TimeOfDay(rawValue: timeOfDayRaw) }
        set { timeOfDayRaw = newValue?.rawValue ?? "" }
    }
}
