//
//  URLExtension.swift
//  weatherApp
//
//  Created by Joshua Brown on 05/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import Foundation

extension URL {
    
    static func weatherURL(_ location: String, _ measurementType: String) -> URL? {
        let apiKey = "b8461df8e110eda062e7f8e374214d92"
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(location)&appid=\(apiKey)&units=\(measurementType)") else {
            return nil
        }
        
        return url
    }
    
    
}
