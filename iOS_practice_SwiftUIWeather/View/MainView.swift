//
//  ContentView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var weatherDetail = OpenWeather.WeatherDetail()
    @State private var selectedUnit = unitOfTemperature.Celsius
    
    // 時間和格式
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter
    }
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    @State var cityIDs: [Int] = DefaultWeather.getDefault(forKey: DefaultsKeys.favoriteList) as? [Int] ?? [1668341, 1668341]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(cityIDs, id: \.self) { city in
                                WeatherCardView(selectedUnit: $selectedUnit, cityID: city)
                                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.5)
                                    .clipped()
                                    .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 0, y: 0)
                            }
                            
                        }
                        .padding()
                    }
                Picker(selection: $selectedUnit, label: Text("Unit of Temperature"), content: {
                    let units = unitOfTemperature.allCases

                    ForEach(units, id: \.self) { (unit) in
                        Text(String(describing: unit)).tag(unit)
                    }
                })
            }
            .onAppear() {
                print("\(Date().description(with: Locale.current)): MainView on Appear")
                cityIDs = DefaultWeather.getDefault(forKey: DefaultsKeys.favoriteList) as! [Int]
                print(cityIDs)
                print("`12")
                
            }
            .navigationBarItems(leading: Button(action: {}, label: {
                Spacer(minLength: 5)
                NavigationLink(destination: MapWeatherView(unit: selectedUnit)) {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(Color("blackAndWhite"))
                }
            }), trailing: Button(action: {}, label: {
                NavigationLink(destination: CityListView(unit: selectedUnit)) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(Color("blackAndWhite"))
                }
                Spacer(minLength: 5)
            }))
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
