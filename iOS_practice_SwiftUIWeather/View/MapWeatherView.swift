//
//  MapWeatherView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2021/2/2.
//

import SwiftUI

struct MapWeatherView: View{
    @ObservedObject var locationManager = LocationManager()
    var unit: unitOfTemperature

    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }

    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    @State private var search: String = ""

    var body: some View {
        VStack {
            
            ZStack {
                Text("location status: \(locationManager.statusString)")
                HStack {
                    Text("latitude: \(userLatitude)")
                    Text("longitude: \(userLongitude)")
                }
            }
        }.onAppear(perform: {
            if locationManager.statusString == "notDetermined" {
                locationManager.requestAuthorization()
            }
            locationManager.startUpdateLocation()
        })
        

    }
    
}

struct MapWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MapWeatherView(unit: unitOfTemperature.Celsius)
    }
}
