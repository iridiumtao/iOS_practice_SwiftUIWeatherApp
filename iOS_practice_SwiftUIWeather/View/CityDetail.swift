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
    
    @State private var showAlert = false
    
    //時間和格式
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter
    }
    
    @State var weatherDetail: OpenWeather.WeatherDetail
    
    // 用來dismiss的東西
    @Environment(\.presentationMode) var presentation
    
//    @Binding var showSecond: Bool
//    @Binding var showThird: Bool
    
    var body: some View {
        ScrollView {
            MapView(coordinate: city.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            VStack(alignment: .leading) {
   
                Text("\(city.name), \(city.country)")
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
                
                Text("\(weatherDetail.time, formatter: taskDateFormat)")
                let feelsLikeWithSelectedUnit = Weather.changeUnitFromKelvin(temperature: weatherDetail.feelsLikeTemperature, unit: unit)
                Text("Feels like \(feelsLikeWithSelectedUnit, specifier: "%.2f")\(symbol). \(weatherDetail.description)")
                Text("Humidity: \(weatherDetail.humidity, specifier: "%.f")")
            }
            .onAppear() {
                Weather.requestWeatherData(cityId: city.id){ (weatherData) in
                    weatherDetail = weatherData
                }
            }
            VStack(alignment: .center) {
                Spacer(minLength: 10)
                Button("Set as Default City") {
                    print("set \(city.name)")
                    showAlert = true
                    DefaultWeather.setDefault(key: DefaultsKeys.city, cityID: city.id)
                }.alert(isPresented: $showAlert, content: { () -> Alert in
                    return Alert(title: Text("Succeed"), message: Text("\(city.name) has been set as default city."))
                })

            }
            
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CityDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        CityDetail(city: City(id: 1665357, coord: coord(lon: 120.46138, lat: 23.124929), country: "TW", name: "Yujing"), unit: .Celsius, weatherDetail: OpenWeather.WeatherDetail())
    }
}
