//
//  TestView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2021/1/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct WeatherCardView: View {
    
    @State var weatherDetail = OpenWeather.WeatherDetail()
    @Binding var selectedUnit: unitOfTemperature
    // ref: https://stackoverflow.com/questions/61335321/setting-a-state-var-from-another-view-in-swiftui
    
    
    // dark mode or not
    @Environment(\.colorScheme) var colorScheme
    
    let cityID: Int
    //@State var city: City
    
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter
    }

    var body: some View {

        ZStack {
            Color("betterPrimary").cornerRadius(8)
                
            //NavigationLink(destination: CityDetail(city: city, unit: selectedUnit)) {
            NavigationLink(destination: CityListView(unit: selectedUnit)) {
                VStack(alignment: .leading) {
       
                    Text("\(weatherDetail.city), \(weatherDetail.countryCode)")
                        .font(Font.largeTitle.bold())
                    
                    let temperatureWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.temperature, unit: selectedUnit)
                    let symbol = Weather.symbolOfUnitOfTemperature(unit: selectedUnit)

                    HStack {
                        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(weatherDetail.weatherIcon)@2x.png")
                        
                        WebImage(url: imageUrl, options: .refreshCached)
                            .placeholder{ Text("☁️") }
                            .frame(width: 48, height: 48, alignment: .center)
                        
                        Text("\(temperatureWithSelectedUnit, specifier: "%.2f")\(symbol)")
                    }
                        .padding(.vertical, 10.0)
                        .font(.system(size: 40))
                    
                    Text("\(weatherDetail.time, formatter: taskDateFormat)")
                    let feelsLikeWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.feelsLikeTemperature, unit: selectedUnit)
                    Text("Feels like \(feelsLikeWithSelectedUnit, specifier: "%.2f")\(symbol). \(weatherDetail.description)")
                    Text("Humidity: \(weatherDetail.humidity, specifier: "%.f")")
                }
            }
            // 字的顏色
            .foregroundColor(.primary)
            
        }.onAppear() {
            Weather.requestWeatherData(cityId: cityID) { (weatherData) in
                weatherDetail = weatherData
            }
        }
        
    }
}
