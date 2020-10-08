//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by Joshua Brown on 05/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
    let name: String
    let weather: [WeatherInfoArray]
    let wind: Wind
    let visibility: Int
    let sys: Sys
}

struct Weather: Decodable {
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct WeatherInfoArray: Decodable {
    let main: String
}

struct Sys: Decodable {
    let sunrise: Double
    let sunset: Double
}
