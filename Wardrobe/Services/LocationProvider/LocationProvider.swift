//
//  LocationProvider.swift
//  Wardrobe
//
//  Created by Anton on 28/06/2025.
//

import CoreLocation

protocol LocationProviderProtocol {
    
    func getCityAndCountry() async throws -> String
    func getCurrentLocation() async throws -> CLLocation
}

final class LocationProvider: NSObject, LocationProviderProtocol {
    
    private let manager: CLLocationManager
    private var locationContinuation: CheckedContinuation<CLLocation, Error>?
    private var permissionContinuation: CheckedContinuation<Void, Error>?
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func getCurrentLocation() async throws -> CLLocation {
        guard CLLocationManager.locationServicesEnabled() else {
            throw LocationError.permissionDenied
        }
        
        // Wait for permission if needed
        try await ensureAuthorization()
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            manager.requestLocation()
        }
    }
    
    private func ensureAuthorization() async throws {
        let status: CLAuthorizationStatus = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            // Request and wait for user input
            return try await withCheckedThrowingContinuation { continuation in
                self.permissionContinuation = continuation
                manager.requestWhenInUseAuthorization()
            }
            
        case .denied, .restricted:
            throw LocationError.permissionDenied
            
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        @unknown default:
            throw LocationError.permissionDenied
        }
    }
    
    func getCityAndCountry() async throws -> String {
        let location: CLLocation = try await getCurrentLocation()
        let placemarks: Array<CLPlacemark> = try await CLGeocoder().reverseGeocodeLocation(location)
        
        guard let placemark: CLPlacemark = placemarks.first,
              let city: String = placemark.locality ?? placemark.subAdministrativeArea,
              let country: String = placemark.country else {
            throw LocationError.placemarkNotFound
        }
        
        return "\(city.uppercased()), \(country.uppercased())"
    }
}

extension LocationProvider: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status: CLAuthorizationStatus = manager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            permissionContinuation?.resume()
        } else if status == .denied || status == .restricted {
            permissionContinuation?.resume(throwing: LocationError.permissionDenied)
        }
        
        permissionContinuation = nil
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: Array<CLLocation>
    ) {
        if let location: CLLocation = locations.first {
            locationContinuation?.resume(returning: location)
        } else {
            locationContinuation?.resume(throwing: LocationError.locationUnavailable)
        }
        
        locationContinuation = nil
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
}

enum LocationError: Error {
    
    case permissionDenied
    case locationUnavailable
    case placemarkNotFound
}
