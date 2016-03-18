//
//  Player.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct Player {
    let name: String
    let picks: Picks
    var pointTotal: Int
    
}

struct Picks {
    let round1: [String]
    let round2: [String]
    let round3: [String]
    let round4: [String]
    let round5: [String]
    let round6: String
}