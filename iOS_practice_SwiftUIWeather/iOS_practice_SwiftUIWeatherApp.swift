//
//  iOS_practice_SwiftUIWeatherApp.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import SwiftUI

@main
struct iOS_practice_SwiftUIWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            
            let weatherDetail = OpenWeather.WeatherDetail()
            
            ContentView(weatherDetail: weatherDetail)
        }
    }
}
