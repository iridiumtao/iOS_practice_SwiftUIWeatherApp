//
//  LocationManager.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2021/2/2.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }
    
    public func requestAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    public func startUpdateLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    public func stopUpdateLocation() {
        self.locationManager.stopUpdatingLocation()
    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        print(#function, location)
    }

}
