//
//  PlayerParser.swift
//  NYT Madness 2016
//
//  Created by Adam Shott on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct PlayerParser {
    
    func parsePlayer(dictionary:Dictionary<String, AnyObject>) -> Player? {
        var realName: String!
        
        var picksDictionary: Dictionary <String, AnyObject> = ["":""]
        if let name = dictionary["name"] as? String {
            realName = name
        }
        
        if let picks = dictionary["picks"] as? Dictionary <String, AnyObject> {
            picksDictionary = picks
        }
        
        let pics = parsePicks(picksDictionary)
        
        return Player(name:realName, picks: pics, pointTotal: 0)
    }
    
    func parsePicks(picksDictionary: Dictionary<String,AnyObject>) -> Picks {
        
        let round1 = (picksDictionary["Round_1"] as? [String] ?? [""]).map { $0.lowercaseString }
        let round2 = (picksDictionary["Round_2"] as? [String] ?? [""]).map { $0.lowercaseString }
        let round3 = (picksDictionary["Round_3"] as? [String] ?? [""]).map { $0.lowercaseString }
        let round4 = (picksDictionary["Round_4"] as? [String] ?? [""]).map { $0.lowercaseString }
        let round5 = (picksDictionary["Round_5"] as? [String] ?? [""]).map { $0.lowercaseString }
        let round6 = (picksDictionary["Round_6"] as? String ?? "").map { $0.lowercaseString }
        
        return Picks(round1:round1, round2: round2, round3:round3, round4:round4, round5:round5, round6:round6!)
    }
}

func calculatePoints(player:Player, tournament: Tournament) -> Int {
    var total = 0
    
    let picks = player.picks
    
    let rounds = [picks.round1, picks.round2, picks.round3, picks.round4, picks.round5]
    
    for (index, round) in rounds.enumerate() {
        for pick in round {
            if index >= tournament.rounds.count {
                continue
            }
            
            let round = tournament.rounds[index]
            if let game: Game = round.games[pick] {
                total = total + game.points
            }
        }
    }
    
    if tournament.rounds.count > 5 {
        let tournamentRound6: TournamentRound = tournament.rounds[5]
        if let championshipGame = tournamentRound6.games[picks.round6] {
            total = total + championshipGame.points
        }
    }
    
    
    return total
}