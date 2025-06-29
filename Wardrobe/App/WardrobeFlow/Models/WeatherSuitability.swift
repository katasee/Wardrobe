//
//  WeatherSuitability.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import Foundation

enum WeatherSuitability: String, Codable, CaseIterable, Identifiable {
    
    case veryHot
    case hot
    case mild
    case cold
    case veryCold
    
    var id: String { rawValue }
    
    var level: Int {
        return switch self {
        case .veryHot: 0
        case .hot: 1
        case .mild: 2
        case .cold: 3
        case .veryCold: 4
        }
    }
    
    static func fromLevel(_ level: Int) -> WeatherSuitability {
        return switch level {
        case 0: .veryHot
        case 1: .hot
        case 2: .mild
        case 3: .cold
        default: .veryCold
        }
    }
}
