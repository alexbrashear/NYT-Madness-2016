//
//  TournamentParser.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

func parseTournament(tournamentDictionary: [String:[[String:Int]]]) -> Tournament {
    var rounds = [TournamentRound]()
    for (index, (round, resultsArray)) in tournamentDictionary.enumerate() {
        var games = [Game]()
        for gameDictionary in resultsArray {
            var teamScores = [TeamScore]()
            for (team, score) in gameDictionary {
                teamScores.append(TeamScore(team, score))
            }
            games.append(Game(teamScore1: teamScores[0], teamScore2: teamScores[1], roundValue: valueForRound(round)))
        }
        rounds.append(TournamentRound(value: index+1, games: games))
    }
    
    return Tournament(rounds: rounds)
}

func valueForRound(round: String) -> Int {
    switch (round.lowercaseString) {
        case "round 1":
            return 1
        case "round 2":
            return 1
        case "round 3":
            return 2
        case "round 4":
            return 4
        case "round 5":
            return 8
        case "round 6":
            return 16
        default:
            return 0
    }
}