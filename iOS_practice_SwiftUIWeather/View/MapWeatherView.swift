//
//  MapWeatherView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2021/2/2.
//

import SwiftUI
import MapKit

struct MapWeatherView: View{
    
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = ""

    var unit: unitOfTemperature
    
    @Environment(\.scenePhase) var scenePhase
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    private func getNearByLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            MapViewMK2(landmarks: landmarks)
                .ignoresSafeArea(edges: .all)
            
            TextField("Search", text: $search, onCommit: {
                self.getNearByLandmarks()
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            .zIndex(1)

            VStack() {

            
                Text("location status: \(locationManager.statusString)")
                Text("latitude: \(userLatitude)")
                Text("longitude: \(userLongitude)")
                    
                
            }.offset(y: 90)

        }
        
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarTitle("Map")
        //.navigationBarHidden(true)
        //.navigationBarBackButtonHidden(false)
        .onAppear(perform: {
            if locationManager.statusString == "notDetermined" {
                locationManager.requestAuthorization()
            }
            locationManager.startUpdateLocation()
            print("appear")
        })
        .onDisappear(perform: {
            locationManager.stopUpdateLocation()
            print("disappear")
        })
        .onChange(of: scenePhase, perform: { newScenePhase in
            switch newScenePhase {
                  case .active:
                    print("App is active")
                  case .inactive:
                    print("App is inactive")
                  case .background:
                    print("App is in background")
                  @unknown default:
                    print("Oh - interesting: I received an unexpected new value.")
                  }
        })
        
        
    }
    
}

struct MapWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MapWeatherView(unit: unitOfTemperature.Celsius)
            
    }
}
