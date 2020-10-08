//
//  TopBanner.swift
//  weatherApp
//
//  Created by Joshua Brown on 07/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import SwiftUI

struct TopBanner: View {
    
    var location: String
    var temperature: Int?
    var weatherDesc: String
    var measurementSymbol: String? 
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(red: 253/255.0, green: 255.0/255.0, blue: 253.0/255.0))
                LocationDataText(textLabel: "\(location)", textSize: 30)
            }.padding(.top, 40)
            
            HStack {
                LocationDataText(textLabel: weatherDesc, textSize: 25)
            }.padding(.bottom, 20)
            
            HStack {
                Spacer()
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .foregroundColor(Color.yellow)
                    .frame(width: 60, height: 60)
                
                LocationDataText(textLabel: "\(String(describing: temperature!))\(measurementSymbol!)", textSize: 80)
                
                Spacer()
                
            }.padding(-30)
        }
    }
}

struct TopBanner_Previews: PreviewProvider {
    static var previews: some View {
        TopBanner(location: "London", temperature: 30, weatherDesc: "Clouds")
    }
}

