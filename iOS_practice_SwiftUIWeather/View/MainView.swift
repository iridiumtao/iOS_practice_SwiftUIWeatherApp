//
//  ContentView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var weatherDetail: OpenWeather.WeatherDetail
    @State private var selectedUnit = unitOfTemperature.Celsius
    // 跳頁 dismiss 用
//    @State var showSecond = false
//    @State var showThird = false
    
    // 時間和格式
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter
    }
        
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CityListView(cities: citiesList, unit: selectedUnit)) {
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
                            
                            //Image(systemName: "heart.fill")
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
                .foregroundColor(Color.black)
                
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
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherDetail = OpenWeather.WeatherDetail()
        ContentView(weatherDetail: weatherDetail)
    }
}