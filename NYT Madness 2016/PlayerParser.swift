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
        let round6 = (picksDictionary["Round_6"] as? [String] ?? [""]).map { $0.lowercaseString }
        
        return Picks(round1:round1, round2: round2, round3:round3, round4:round4, round5:round5, round6:round6)
    }
}

func calculatePoints(player:Player, tournament: Tournament) -> Int {
    var total = 0
    
    let picks = [player.picks.round1,
                 player.picks.round2,
                 player.picks.round3,
                 player.picks.round4,
                 player.picks.round5,
                 player.picks.round6]
    
    print("current player: \(player.name)")
    
    for (currentRound, picksByRound) in picks.enumerate() {
        print("Round Total: \(total)")
        let roundResults = tournament.rounds[currentRound]
        for pick in picksByRound {
            if currentRound >= tournament.rounds.count {
                continue
            }
            
            if let correctPick: Game = roundResults.games[pick] {
                total = total + correctPick.points
            } else {
                print("INCORRECT - pick: \(pick), round: \(currentRound)")
            }
        }
    }
    
    return total
}