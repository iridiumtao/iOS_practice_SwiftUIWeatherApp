//
//  ModelView.swift
//  iOS_practice_SwiftUIWeather
//
//  Created by 歐東 on 2020/11/25.
//

import Foundation
import Combine

// ViewModel
class Weather: ObservableObject {
    
    static let apiURL = "https://api.openweathermap.org/data/2.5/weather"
    
    private var weather = OpenWeather()
    
    static func requestWeatherData(query: String = "taipei", completion: @escaping (OpenWeather.WeatherDetail) -> ()){
        
        let path = Bundle.main.path(forResource: "apikey", ofType: "txt") // file path for file "data.txt"
        let apiKey = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        
        let jsonURLString = "\(apiURL)?q=\(query)&appid=\(apiKey)"
        // make URL
        guard let url = URL(string: jsonURLString) else { print("哭啊"); return }

        var weatherRaw: OpenWeatherJson? = nil
        // create a session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check for error
            if error != nil {
                print("check for error")
                print(error!.localizedDescription)
            }
            // check for 200 OK status
            guard let data = data else { return }
            do {
                weatherRaw = try JSONDecoder().decode(OpenWeatherJson.self, from: data)
                print("in do func")
                if let weatherRaw = weatherRaw {
                    
                    completion(OpenWeather(rawJson: weatherRaw).weatherDetail)
                }
            } catch let err {
                print ("Json Err", err)
            }
            // start the session
        }.resume()
    }
    
    static func changeUnitFromKelvin(temperature kelvin: Double, unit: unitOfTemperature) -> Double {
        switch unit {
        case .Celsius:
            return (kelvin - 273.15)
        case .Fahrenheit:
            return ((kelvin * (9 / 5)) - 459.67)
        case .Kelvin:
            return kelvin
        case .Rankine:
            return (kelvin * (9 / 5))
        case .Delisle:
            return (373.15 - kelvin) * (3 / 2)
        case .Newton:
            return (kelvin - 273.15) * (33 / 100)
        case .Réaumur:
            return ((kelvin - 273.15) * (4 / 5))
        case .Rømer:
            return ((kelvin - 273.15) * (21 / 40) + 7.5)
        }
    }
    
    static func symbolOfUnitOfTemperature(unit: unitOfTemperature) -> String {
        switch unit {
        case .Celsius:
            return "°C"
        case .Fahrenheit:
            return "°F"
        case .Kelvin:
            return "K"
        case .Rankine:
            return "°R"
        case .Delisle:
            return "°De"
        case .Newton:
            return "°N"
        case .Réaumur:
            return "°Ré"
        case .Rømer:
            return "°Rø"
        }
    }

}
