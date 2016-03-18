//
//  TournamentRound.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct TournamentRound {
    var value: Int
    var games: [String:Game]
    
    init(value: Int, games: [String:Game]) {
        self.value = value
        self.games = games
    }
}
