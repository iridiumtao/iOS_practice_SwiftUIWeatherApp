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
    @State var weatherDetail = OpenWeather.WeatherDetail()
    
    // onAppear 時寫入
    @State var favoriteList: [Int] = []
    
    // is favorite = "star.fill"
    // is not favorite = "star"
    // onAppear 時寫入
    @State private var isFavorite = false
    
    //時間和格式
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter
    }
    
//    init(city: City, unit: unitOfTemperature) {
//        self.city = city
//        self.unit = unit
//    }
//
//    init(cityID: Int, unit: unitOfTemperature) {
//
//
//        self.init(city: city, unit: unit)
//    }
    
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
                // 更新favorite
                favoriteList = DefaultWeather.getDefault(forKey: DefaultsKeys.favoriteList)  as! [Int]
                isFavorite = favoriteList.contains(city.id)
                print("CityDetail onAppear")
                print(favoriteList)
                
                Weather.requestWeatherData(cityId: city.id){ (weatherData) in
                    weatherDetail = weatherData
                }
            }.navigationBarItems(
                trailing:
                    Button(action: {

                        isFavorite = !isFavorite
                        if isFavorite {
                            favoriteList.append(city.id)
                        } else {
                            favoriteList = favoriteList.filter { $0 != city.id }
                        }
                        print("isFav \(isFavorite)")
                        
                        DefaultWeather.setDefault(value: favoriteList, forKey: DefaultsKeys.favoriteList.rawValue)
                        
                        print(favoriteList)
                    }) {
                        Image(systemName: (isFavorite ? "star.fill" : "star"))
                    }
            )
            
        }
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CityDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        CityDetail(city: City(id: 1665357, coord: coord(lon: 120.46138, lat: 23.124929), country: "TW", name: "Yujing"), unit: .Celsius)
    }
}
