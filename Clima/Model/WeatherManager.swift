//
//  WeatherManager.swift
//  Clima
//
//  Created by Aliaksandr Zuyeu on 31.07.25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    let apiKey = "c81936bb7bc122295a5690605a55073f"
    let metric = "&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)appid=\(apiKey)&q=\(cityName)\(metric)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

//MARK: - fetchWeather with current location
extension WeatherManager {
    func fetchWeather(latitude lat: CLLocationDegrees, longitute lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)lat=\(lat)&lon=\(lon)&appid=\(apiKey)\(metric)"
        //    "https://api.openweathermap.org/data/2.5/weather?lat=51&lon=-0.1&appid=c81936bb7bc122295a5690605a55073f"
        performRequest(with: urlString)
    }
}
