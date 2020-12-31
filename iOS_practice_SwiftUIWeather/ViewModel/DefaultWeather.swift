//
//  DefaultWeather.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/31.
//

import Foundation

class DefaultWeather {
    static func getDefault() -> Int {
        
        // Getting
        let defaults = UserDefaults.standard
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            return defaults.integer(forKey: DefaultsKeys.city.rawValue)

        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            setDefault(key: DefaultsKeys.city, cityID: 1668341)
            return defaults.integer(forKey: DefaultsKeys.city.rawValue)
        }
        
    }
    
    static func setDefault(key: DefaultsKeys, cityID: Int) {
        // Setting

        let defaults = UserDefaults.standard
        defaults.set(cityID, forKey: key.rawValue)
        

    }
}

enum DefaultsKeys: String {
    case city = "city"
}
