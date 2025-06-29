//
//  StreetViewModel.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI
import CoreLocation

@Observable
final class StreetViewModel {

    struct State {

        var selectedItems: Dictionary<TimeOfDay, Array<ClothingItem>> = .init()
        var selectedTimeOfDay: TimeOfDay?
        var currentTemparature: String = "..."
        var currentLocation: String = ""
        var isLoading: Bool = false
        var error: AppError?
    }


    private let locationProvider: LocationProviderProtocol
    private let weatherProvider: WeatherProviderProtocol

    var state: State

    let wardrobeRepository: WardrobeRepositoryProtocol

    init(
        wardrobeRepository: WardrobeRepositoryProtocol,
        locationProvider: LocationProviderProtocol,
        weatherProvider: WeatherProviderProtocol,
        state: State = .init()
    ) {
        self.wardrobeRepository = wardrobeRepository
        self.locationProvider = locationProvider
        self.weatherProvider = weatherProvider
        self.state = state
    }

    func loadData() async {
        state.isLoading = true
        defer {
            state.isLoading = false
        }
        await loadCityAndCountry()
        await loadTemperature()
        await loadSelectedOutfitsForAllTimes()
    }

    func loadCityAndCountry() async {
        do {
            let cityAndCountry: String = try await locationProvider.getCityAndCountry()
            state.currentLocation = cityAndCountry
        } catch {
            state.currentLocation = "Unknown"
            state.error = AppError(message: "Could not load location.")
        }
    }

    func loadTemperature() async {
        do {
            let location: CLLocation = try await locationProvider.getCurrentLocation()
            let temperature: String = try await weatherProvider.fetchCurrentWeather(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )

            state.currentTemparature = temperature
        } catch {
            state.currentTemparature = "?"
            state.error = AppError(message: "Could not load weather.")
        }
    }

    @MainActor
    func loadSelectedOutfitsForAllTimes() {
        for time in TimeOfDay.allCases {
            loadSelectedOutfits(for: time)
        }
    }

    @MainActor
    func loadSelectedOutfits(for timeOfDay: TimeOfDay) {
        let today: Date = Calendar.current.startOfDay(for: .now)

        do {
            if let outfit: OutfitSelection = try wardrobeRepository.getOutfitSelection(
                for: today,
                timeOfDay: timeOfDay
            ) {
                let items: Array<ClothingItem> = outfit.items.compactMap { $0.clothingItem }
                state.selectedItems[timeOfDay] = items
            } else {
                state.selectedItems[timeOfDay] = []
            }
        } catch {
            state.error = AppError(message: "Failed to load outfits")
            state.selectedItems[timeOfDay] = []
        }
    }
}
