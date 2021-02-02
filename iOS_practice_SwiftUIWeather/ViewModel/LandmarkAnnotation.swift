//
//  LandmarkAnnotation.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2021/2/2.
//

import MapKit


final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
