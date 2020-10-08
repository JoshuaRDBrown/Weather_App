//
//  ContentRow.swift
//  weatherApp
//
//  Created by Joshua Brown on 07/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import SwiftUI

struct ContentRow: View {
    
    var items: [String: String]
    
    var body: some View {
        
        HStack {
            ForEach(items.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Spacer()
                    VStack {
                        Text(key).font(Font.body.bold())
                        Text(value)
                    }
                    Spacer()
                    Divider().frame(width: 4,height: 40).foregroundColor(Color.gray)
                }
                
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
        }.background(Color(red: 117/255.0, green: 161.0/255.0, blue: 189.0/255.0)).cornerRadius(10)
            .padding(.top, 40)
    }
    
}

struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(items: ["thing" : "thing2"])
    }
}
