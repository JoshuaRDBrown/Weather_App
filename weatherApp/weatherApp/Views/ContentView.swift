//
//  ContentView.swift
//  weatherApp
//
//  Created by Joshua Brown on 02/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import SwiftUI

enum MeasurementType: CaseIterable {
    case metric
    case imperial
}

extension MeasurementType {
    var name: String {
        switch self {
        case .metric:
            return "metric"
        case .imperial:
            return "imperial"
        }
    }
}

struct ContentView: View {
    
    @ObservedObject private var weatherDataViewModel = WeatherDataViewModel()
    @State private var location: String = ""
    @State private var isViewingPreferences = false
    @State var measurementType: MeasurementType = .metric
    @State private var measurementSymbol: String?
    
    var body: some View {
        
        ZStack {
            VStack {
                
                if self.weatherDataViewModel.temperature != nil {
    
                    TopBanner(location: self.weatherDataViewModel.location, temperature: self.weatherDataViewModel.temperature, weatherDesc: self.weatherDataViewModel.weatherDec, measurementSymbol: measurementSymbol)
                    
                    HStack {
                        Text(self.weatherDataViewModel.currentDate)
                            .foregroundColor(Color(red: 117/255.0, green: 161.0/255.0, blue: 189.0/255.0))
                        Spacer()
                        
                        VStack {
                            Text("Lowest: \(self.weatherDataViewModel.minTemp!)\(measurementSymbol!)" as String)
                            Text(" Highest: \(self.weatherDataViewModel.maxTemp!)\(measurementSymbol!)" as String)
                        }.foregroundColor(Color(red: 117/255.0, green: 161.0/255.0, blue: 189.0/255.0))
                        
                    }.padding(.top, 40)
                    
                    ContentRow(items: [
                        "Sunrise" : "\(self.weatherDataViewModel.sunRise!)",
                        "Sunset" : "\(self.weatherDataViewModel.sunSet!)",
                        "Feels like" : "\(self.weatherDataViewModel.feelsLike!)\(measurementSymbol!)",
                    ])
                    
                    ContentRow(items: [
                        "Wind speed" : "\(self.weatherDataViewModel.windSpeed!) KM",
                        "Wind direction" : "\(self.weatherDataViewModel.windDirection!)"
                    ])
                    
                    ContentRow(items: [
                        "Visibility" : "\(self.weatherDataViewModel.visibility!) KM",
                        "Humidity" : "\(self.weatherDataViewModel.humidity!)%",
                        "Pressure" : "\(self.weatherDataViewModel.preasure!) hPa"
                    ])
                    
                    Spacer()
                    Text("Weather served by the open weather API.").foregroundColor(Color.white)
                    
                } else {
                    Spacer()
                    Text("Weather App").font(.system(size: 50)).foregroundColor(Color.white)
                    
                    Spacer()
                    TextField("Search location...", text: self.$location, onEditingChanged: { _ in }, onCommit: {
                        
                        self.measurementSymbol = self.measurementType.name == "metric" ? "°C" : "°F"
                        
                        self.weatherDataViewModel.fetchWeather(location: self.location, measurementType: self.measurementType.name)
                    }).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                        Spacer()
                        Text("Use the search box to find the weather information for your area.").foregroundColor(Color.black)
                    }.padding().background(Color.yellow).cornerRadius(10)
                    
                    if(weatherDataViewModel.errorMessage != "") {
                        Text(weatherDataViewModel.errorMessage).font(.system(size: 20)).foregroundColor(Color.red)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.isViewingPreferences.toggle()
                        }
                    }) {
                        Text("Preferences").foregroundColor(Color.white)
                    }.sheet(isPresented: $isViewingPreferences) {
                        Text("Preferences").font(.largeTitle).padding(.top, 20)
                        List {
                            HStack {
                                Text("Measurement type").font(.headline)
                                Spacer()
                                Picker(selection: self.$measurementType, label: Text("Measurement Type")) {
                                    ForEach(MeasurementType.allCases, id: \.self) { measurement in
                                        Text(measurement.name)
                                    }
                                }.pickerStyle(SegmentedPickerStyle()).padding()
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            }.padding()
        }.background(Color(red: 36.0/255.0, green: 55.0/255.0, blue: 85.0/255.0 )).edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
