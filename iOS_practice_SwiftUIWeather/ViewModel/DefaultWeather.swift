//
//  DefaultWeather.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/12/31.
//

import Foundation

class DefaultWeather {
    static func getDefault(forKey key: DefaultsKeys) -> Any {
        
        // Getting
        let defaults = UserDefaults.standard
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            setDefault(value: true, forKey: DefaultsKeys.launchedBefore.rawValue)
            
            setDefault(value: [166834], forKey: DefaultsKeys.city.rawValue)
            setDefault(value: [], forKey: DefaultsKeys.favoriteList.rawValue)
        }
        
        switch key {
        case .city:
            return defaults.array(forKey: key.rawValue) ?? [1668341]
        case .favoriteList:
            return defaults.array(forKey: key.rawValue) ?? []
        case .launchedBefore:
            return defaults.bool(forKey: key.rawValue)
        }
    }
    
    static func setDefault(value: Any, forKey key: String) {
        // Setting

        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)

    }
}

// 存放預設字串(defaults的類別不是從這裡設定)
enum DefaultsKeys: String {
    case launchedBefore = "launchedBefore"
    case city = "city"
    case favoriteList = "favoriteList"
}
