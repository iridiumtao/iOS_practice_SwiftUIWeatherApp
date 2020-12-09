//
//  ContentView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var weatherDetail: OpenWeather.WeatherDetail
    
    @State private var selectedUnit = unitOfTemperature.Celsius
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
   
                Text("\(weatherDetail.city), \(weatherDetail.countryCode)")
                    .font(Font.largeTitle.bold())
                
                let temperatureWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.temperature, unit: selectedUnit)
                let symbol = Weather.symbolOfUnitOfTemperature(unit: selectedUnit)

                HStack {
                    Text("☁️")
                    Text("\(temperatureWithSelectedUnit, specifier: "%.2f")\(symbol)")
                }
                    .padding(.vertical, 10.0)
                    .font(.system(size: 40))
                
                let feelsLikeWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.feelsLikeTemperature, unit: selectedUnit)
                Text("Feels like \(feelsLikeWithSelectedUnit, specifier: "%.2f")\(symbol). \(weatherDetail.description)")
            }
            
            
            Picker(selection: $selectedUnit, label: Text("Unit of Temperature"), content: {
                let units = unitOfTemperature.allCases
                
                ForEach(units, id: \.self) { (unit) in
                    Text(String(describing: unit)).tag(unit)
                }
               
                
            })
            
            
        }.onAppear() {
            Weather.requestWeatherData(){ (weatherData) in
                weatherDetail = weatherData
            }
        }
    }
    
}
