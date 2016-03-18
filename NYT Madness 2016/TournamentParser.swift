//
//  TournamentParser.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct TournamentParser {

    let teamProvider: TeamProvider
    
    init(teamProvider: TeamProvider) {
        self.teamProvider = teamProvider
    }
    
    func parseTournament(tournamentDictionary: [String:[[String:Int]]]) -> Tournament {
        var rounds = [TournamentRound]()
        for (round, resultsArray) in tournamentDictionary {
            var games = [Game]()
            for gameDictionary in resultsArray {
                var teamScores = [TeamScore]()
                for (teamName, score) in gameDictionary {
                    teamScores.append(TeamScore(team: teamProvider.team(teamName)!, score: score))
                }
                games.append(Game(teamScore1: teamScores[0], teamScore2: teamScores[1], roundValue: valueForRound(round)))
            }
            rounds.append(TournamentRound(value: valueForRound(round), games: games))
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
}