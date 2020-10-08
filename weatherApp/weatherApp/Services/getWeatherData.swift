//
//  getWeatherData.swift
//  weatherApp
//
//  Created by Joshua Brown on 02/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case jsonError(Error)
}

class GetWeatherData {
    
    func getWeather(location: String, measurementType: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard let url = URL.weatherURL(location, measurementType) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.jsonError(error)))
            }
        }.resume()
    }
}
