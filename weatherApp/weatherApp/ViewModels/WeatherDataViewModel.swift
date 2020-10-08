//
//  WeatherDataViewModel.swift
//  weatherApp
//
//  Created by Joshua Brown on 05/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import Foundation

final class WeatherDataViewModel: ObservableObject {
    
    @Published private var weather: WeatherResponse?
    @Published var errorMessage: String = ""
    
    func fetchWeather(location: String, measurementType: String) {
        
        guard let location = location.escaped() else {
            DispatchQueue.main.async {
                self.errorMessage = "Location is not valid"
            }
            return
        }
        
        GetWeatherData().getWeather(location: location, measurementType: measurementType) { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weather = weather
                }
            case .failure(_ ):
                DispatchQueue.main.async {
                    self.errorMessage = "Unable to find the weather for location"
                    self.weather = nil
                }
            }
        }
    }
    
    func roundToWholeNumber(number: Double) -> Int {
        return Int(Darwin.round(number))
    }
    
    func getDateFromTimeStamp(timeStamp: Double) -> String {
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    var currentDate: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    var sunRise: String? {
        guard let sunrise = weather?.sys.sunrise else {
            return nil
        }
        
        return getDateFromTimeStamp(timeStamp: sunrise)
    }
    
    var sunSet: String? {
        guard let sunset = weather?.sys.sunset else {
            return nil
        }
        
        return getDateFromTimeStamp(timeStamp: sunset)
    }
    
    var weatherDec: String {
        guard let weatherType = weather?.weather.first?.main else {
            return ""
        }
        
        return weatherType
    }
    
    var location: String {
        guard let location = weather?.name else {
            return ""
        }
        
        return location
    }
    
    var temperature: Int? {
        guard let temp = weather?.main.temp else {
            return nil
        }
        
        return roundToWholeNumber(number: temp)
    }
    
    var maxTemp: Int? {
        guard let maxTemp = weather?.main.temp_max else {
            return nil
        }
        
        return roundToWholeNumber(number: maxTemp)
    }
    
    var minTemp: Int? {
        guard let minTemp = weather?.main.temp_min else {
            return nil
        }
        
        return roundToWholeNumber(number: minTemp)
    }
    
    var feelsLike: Int? {
        guard let feelsLike = weather?.main.feels_like else {
            return nil
        }
        
        return roundToWholeNumber(number: feelsLike)
    }
    
    var humidity: Int? {
        guard let humidity = weather?.main.humidity else {
            return nil
        }
        
        return roundToWholeNumber(number: humidity)
    }
    
    var preasure: Int? {
        guard let pressure = weather?.main.pressure else {
            return nil
        }
        
        return roundToWholeNumber(number: pressure)
    }
    
    var visibility: Int? {
        guard let visibility = weather?.visibility else {
            return nil
        }
        
        return visibility
    }
    
    var windSpeed: Double? {
        guard let windSpeed = weather?.wind.speed else {
            return nil
        }
        
        return windSpeed
    }
    
    var windDirection: String? {
        guard let windDirection = weather?.wind.deg else {
            return nil
        }
        let value = floor((Double(windDirection) / 22.5) + 0.5)
        let compassDirections = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        
        return compassDirections[(Int(value) % 16)]
    }
}
