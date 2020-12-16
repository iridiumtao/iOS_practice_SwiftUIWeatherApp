//
//  CityListView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/16.
//

import SwiftUI

struct CityListView : View{
    
    var cities: [City] = []
    
    var unit: unitOfTemperature
    
//    @Binding var showSecond: Bool
//    @Binding var showThird: Bool
    
    var body: some View {
        
        List(cities) { city in
            CityList(city: city, unit: unit)
        }.navigationBarTitle("Cities")
        
    }
    
}

struct CityListView_Previews : PreviewProvider {
    static var previews: some View {
//        @State var showSecondPreview: Bool = false
//        @State var showThirdPreview: Bool = false
        
        CityListView(cities: citiesList, unit: .Celsius)
    }
}

struct CityList: View {
    let city: City
    let unit: unitOfTemperature
    
//    @Binding var showSecond: Bool
//    @Binding var showThird: Bool

    var body: some View {
        NavigationLink(destination: CityDetail(city: city, unit: unit, weatherDetail: OpenWeather.WeatherDetail())) {
            VStack(alignment: .leading, spacing: nil, content: {
                if let state = city.state {
                    Text(city.city + ", " + state)
                } else {
                    Text(city.city)
                }
                Text(city.country)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            })
        }
        
    }
}

