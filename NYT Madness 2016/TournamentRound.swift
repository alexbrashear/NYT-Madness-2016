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
    var games: [Game]
    
    init(value: Int, games: [Game]) {
        self.games = games
        self.value = value
    }
}
