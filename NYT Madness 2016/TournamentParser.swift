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
        var rounds = [TournamentRound](count: 6, repeatedValue: TournamentRound(value: -1, games: [:]))
        rounds.reserveCapacity(6)
        for (round, resultsArray) in tournamentDictionary {
            var games = [Game]()
            let (roundValue, roundPosition) = valueAndPositionForRound(round)
            for gameDictionary in resultsArray {
                var teamScores = [TeamScore]()
                for (teamName, score) in gameDictionary {
                    teamScores.append(TeamScore(team: teamProvider.team(teamName)!, score: score))
                }
                let game = Game(teamScore1: teamScores[0], teamScore2: teamScores[1], roundValue: roundValue)
                games.append(game)
            }
            rounds[roundPosition] = TournamentRound(value: roundValue, games: winnerDictionary(games))
        }
        
        return Tournament(rounds: rounds)
    }

    func valueAndPositionForRound(round: String) -> (Int, Int) {
        switch (round) {
            case "Round_1":
                return (1, 0)
            case "Round_2":
                return (1, 1)
            case "Round_3":
                return (2, 2)
            case "Round_4":
                return (4, 3)
            case "Round_5":
                return (8, 4)
            case "Round_6":
                return (16, 5)
            default:
                print("ERROR: No valid round found for string: \(round)")
                return (-1, -1)
        }
    }
    
    func winnerDictionary(games: [Game]) -> [String:Game] {
        var dictionary = [String:Game]()
        for game in games {
            if game.teamScore1.score > game.teamScore2.score {
                dictionary[game.teamScore1.team.name] = game
            }
            else {
                dictionary[game.teamScore2.team.name] = game
            }
        }
        return dictionary
    }
}