//
//  StringExtension.swift
//  weatherApp
//
//  Created by Joshua Brown on 06/10/2020.
//  Copyright © 2020 Joshua Brown. All rights reserved.
//

import Foundation

extension String {
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
