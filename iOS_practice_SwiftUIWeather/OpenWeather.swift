//
//  Model.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import Foundation

// Model
struct OpenWeather {
    
    var weatherDetail: WeatherDetail
    
    init(rawJson: OpenWeatherJson) {
        weatherDetail = WeatherDetail(city: rawJson.name,
                                      countryCode: rawJson.sys.country,
                                      weatherIcon: rawJson.weather[0].icon,
                                      temperature: rawJson.main.temp,
                                      feelsLikeTemperature: rawJson.main.feels_like,
                                      description: rawJson.weather[0].description,
                                      time: Date(timeIntervalSince1970: rawJson.dt))
    }
    
    init() {
        weatherDetail = WeatherDetail()
    }
    
    struct WeatherDetail {
        var city: String = "default"
        var countryCode: String = "default"
        var weatherIcon: String = "default"
        var temperature: Double = 0.0
        var feelsLikeTemperature: Double = 0.0
        var description: String = "default"
        var time: Date = Date()
    }
}
