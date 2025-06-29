//
//  DateFormatter+Extensions.swift.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import Foundation

extension DateFormatter {

    static let localizedDayMonthYear: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.autoupdatingCurrent
        return formatter
    }()
}

extension Date {
    
    var localizedDayMonthYear: String {
        DateFormatter.localizedDayMonthYear.string(from: self)
    }
}
