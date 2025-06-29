//
//  OpenWeatherResponse.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

struct OpenWeatherResponse: Decodable {

    let main: Main
    let name: String

    struct Main: Decodable {
 
        let temp: Double
    }
}
