//
//  DecodeCitiyList.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/30.
//

import Foundation

struct DecodeCityList {
    static func decode(completion: @escaping ([City]) -> ()) {
        if let path = Bundle.main.path(forResource: "current.city.list.min", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let citiesData = try! JSONDecoder().decode([City].self, from: data)
                
                completion(citiesData)
                
            } catch {
                print("data read error!!!")
            }
        } else {
            print("file path error!!!")
        }
    }
}
