//
//  ContentView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var weatherDetail = OpenWeather.WeatherDetail()
    @State private var selectedUnit = unitOfTemperature.Celsius
    
    // 時間和格式
    var taskDateFormat: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd HH:mm"
        return formatter
    }
    
    //@State var cityIDs: [Int] = DefaultWeather.getDefault(forKey: DefaultsKeys.city) as? [Int] ?? [1668341, 1668341]
    // just for test
    @State var cityIDs: [Int] = [1668341, 1668355]
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(0 ..< cityIDs.count) { city in
                            WeatherCardView(cityID: cityIDs[city])
                        }
                    }
                    .padding()
                }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
