//
//  Font+Montserrat.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI

extension Font {

    static func montserrat(
        _ size: CGFloat,
        _ weight: MontserratFontWeight
    ) -> Font {
        .custom(
            weight.rawValue,
            size: size
        )
    }
}
