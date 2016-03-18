//
//  Game.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct Game {
    let teamScore1: TeamScore
    let teamScore2: TeamScore
    let round: TournamentRound
    
    var winningTeam: Team {
        if teamScore1.score > teamScore2.score {
            return teamScore1.team
        }
        return teamScore2.team
    }
    
    private var losingTeam: Team {
        if teamScore1.score < teamScore2.score {
            return teamScore1.team
        }
        return teamScore2.team
    }
    
    var points: Int {
        let seedDifferential = winningTeam.seed - losingTeam.seed
        if seedDifferential > 0 {
            return seedDifferential * round.value
        }
        return round.value
    }
}

struct TeamScore {
    let team: Team
    let score: Int
}