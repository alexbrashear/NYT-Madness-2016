//
//  Team.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct Team {
    var name: String
    var seed: Int
    
    init(name: String, seed: Int) {
        self.name = name.lowercaseString
        self.seed = seed
    }
}