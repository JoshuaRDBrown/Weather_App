//
//  LocationSearcher.swift
//  weatherApp
//
//  Created by Joshua Brown on 06/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import SwiftUI

struct LocationSearcher: View {
    var body: some View {
        TextField("Search location...", text: self.$location, onEditingChanged: { _ in }, onCommit: {
            self.weatherDataViewModel.fetchWeather(location: self.location)
        }).textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct LocationSearcher_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearcher()
    }
}
