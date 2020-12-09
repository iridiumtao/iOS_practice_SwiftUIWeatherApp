//
//  OpenWeather.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import Foundation

struct OpenWeatherJson: Decodable {
    let coord: coord
    let weather: [weather]
    let base: String
    let main: main
    let visibility: Double
    let wind: wind
    let clouds: clouds
    let dt: Double
    let sys: sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct coord: Decodable {
    let lon: Double
    let lat: Double
}

struct weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct wind: Decodable {
    let speed: Double
    let deg: Double
}

struct clouds: Decodable {
    let all: Int
}

struct sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
