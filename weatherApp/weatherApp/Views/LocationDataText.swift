//
//  LocationDataText.swift
//  weatherApp
//
//  Created by Joshua Brown on 06/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import SwiftUI

struct LocationDataText: View {
    
    var textLabel: String
    var textSize: Int
    
    
    var body: some View {
        Text(textLabel)
            .font(.system(size: CGFloat(textSize)))
            .foregroundColor(Color(red: 253/255.0, green: 255.0/255.0, blue: 253.0/255.0 ))
    }
}

struct LocationDataText_Previews: PreviewProvider {
    static var previews: some View {
        LocationDataText(textLabel: "Temp: 50", textSize: 50)
    }
}
