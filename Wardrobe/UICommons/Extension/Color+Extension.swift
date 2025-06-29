//
//  Color+Extension.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI

extension Color {

    func toHex() -> String? {
        UIColor(self).toHex()
    }

    init(hex: String) {
        let scanner: Scanner = .init(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red: Double = .init((rgb >> 16) & 0xFF) / 255
        let green: Double = .init((rgb >> 8) & 0xFF) / 255
        let blue: Double = .init(rgb & 0xFF) / 255

        self.init(
            red: red,
            green: green,
            blue: blue
        )
    }
}

extension UIColor {

    func toHex() -> String? {
        guard let components: Array<CGFloat> = cgColor.components,
              components.count >= 3 else {
            return nil
        }
        let red: Int = .init(components[0] * 255)
        let green: Int = .init(components[1] * 255)
        let blue: Int = .init(components[2] * 255)

        return .init(
            format: "#%02X%02X%02X",
            red,
            green,
            blue
        )
    }
}
