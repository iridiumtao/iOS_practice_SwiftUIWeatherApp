//
//  CurrentCityList.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/30.
//

import Foundation

struct CurrentCityList: Decodable {
    let cityList: [CityListAll]
    
}

struct CityListAll: Decodable {
    let id: Int
    let coord: coord
    let country: String

    let name: String
}




