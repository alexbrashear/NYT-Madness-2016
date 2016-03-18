//
//  PlayerParser.swift
//  NYT Madness 2016
//
//  Created by Adam Shott on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct PlayerParser {
    let tournament: Tournament
    
    func parsePlayer(dictionary:Dictionary<String, AnyObject>) -> Player {
        var realName: String!
        var picksDictionary: Dictionary <String, [String]>!
        if let name = dictionary["name"] as? String {
            realName = name
        }
        
        if let picks = dictionary["picks"] as? Dictionary <String, [String]> {
            picksDictionary = picks
        }
        
        let pics = parsePicks(picksDictionary)
        
        return Player(name:realName, picks: pics, pointTotal: 0)
    }
    
    func parsePicks(picksDictionary: Dictionary<String,[String]>) -> Picks {
        
        let round1 = picksDictionary["first"]
        let round2 = picksDictionary["second"]
        let round3 = picksDictionary["sweet_sixteen"]
        let round4 = picksDictionary["elite_eight"]
        let round5 = picksDictionary["final_four"]
        let round6 = picksDictionary["final"]
        
        return Picks(round1:round1!, round2: round2!, round3:round3!, round4:round4!, round5:round5!, round6:round6!)
        
    }
    
}