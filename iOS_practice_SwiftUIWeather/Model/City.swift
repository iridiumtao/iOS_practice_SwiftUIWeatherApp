//
//  Cities.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/16.
//

import Foundation
import CoreLocation

struct City: Identifiable {
    var id: Int
    var city: String
    var state: String?
    var country: String
    var coord: coord
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coord.lat,
            longitude: coord.lon)
    }
    
}

let citiesList = [
    City(id: 5128581, city: "New York City", state: "New York", country: "US", coord: coord(lon: -74.005966, lat: 40.714272)),
    City(id: 1668341, city: "Taipei", state: nil, country: "TW", coord: coord(lon: 121.531853, lat: 25.04776)),
    City(id: 1668399, city: "Taichung", state: nil, country: "TW", coord: coord(lon: 120.683899, lat: 24.1469)),
    City(id: 1668355, city: "Tainan", state: nil, country: "TW", coord: coord(lon: 120.213333, lat: 22.990829))
]
