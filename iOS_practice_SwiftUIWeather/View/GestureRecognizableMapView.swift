//
//  gestureRecognizableMapView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2021/2/2.
//

import Foundation
import MapKit

/// To make gesture recognition available inside MapView.
/// 
/// Use as normal MKMapView as MKMapView is the superclass.
/// Link: https://developer.apple.com/forums/thread/122105
final class GestureRecognizableMapView: MKMapView {
    var onLongPress: (CLLocationCoordinate2D) -> Void = { _ in }
    
    init() {
        super.init(frame: .zero)
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gestureRecognizer.minimumPressDuration = 0.8
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let location = sender.location(in: self)
            let coordinate = convert(location, toCoordinateFrom: self)
            onLongPress(coordinate)
            
            print(coordinate)
            
            // todo: 已可取得點擊位置的座標，下一步：傳送座標給API並顯示資訊
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
