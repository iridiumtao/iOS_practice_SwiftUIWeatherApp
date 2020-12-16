//
//  CityDetail.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/16.
//

import SwiftUI
import SDWebImageSwiftUI

struct CityDetail: View {
    var city: City
    var unit: unitOfTemperature
    
    @State var weatherDetail: OpenWeather.WeatherDetail
    
    var body: some View {
        ScrollView {
            MapView(coordinate: city.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            VStack(alignment: .leading) {
   
                Text("\(city.city), \(city.country)")
                    .font(Font.largeTitle.bold())
                    
                
                let temperatureWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.temperature, unit: unit)
                let symbol = Weather.symbolOfUnitOfTemperature(unit: unit)

                HStack {
                    let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(weatherDetail.weatherIcon)@2x.png")
                    
                    WebImage(url: imageUrl, options: .refreshCached)
                        .placeholder{ Text("☁️") }
                        .frame(width: 48, height: 48, alignment: .center)
                    
                    //Image(systemName: "heart.fill")
                    Text("\(temperatureWithSelectedUnit, specifier: "%.2f")\(symbol)")
                }
                    .padding(.vertical, 10.0)
                    .font(.system(size: 40))
                
                let feelsLikeWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.feelsLikeTemperature, unit: unit)
                Text("Feels like \(feelsLikeWithSelectedUnit, specifier: "%.2f")\(symbol). \(weatherDetail.description)")
            }
            .onAppear() {
                Weather.requestWeatherData(cityId: city.id){ (weatherData) in
                    weatherDetail = weatherData
                }
            }
        }
        .navigationTitle(city.city)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CityDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        CityDetail(city: City(id: 1665357, city: "Yujing", state: nil, country: "TW", coord: coord(lon: 120.46138, lat: 23.124929)), unit: .Celsius, weatherDetail: OpenWeather.WeatherDetail())
    }
}
