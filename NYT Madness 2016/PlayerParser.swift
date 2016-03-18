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
        
        let round1 = picksDictionary["first"] as? [String] ?? [""]
        let round2 = picksDictionary["second"] as? [String] ?? [""]
        let round3 = picksDictionary["sweet_sixteen"] as? [String] ?? [""]
        let round4 = picksDictionary["elite_eight"] as? [String] ?? [""]
        let round5 = picksDictionary["final_four"] as? [String] ?? [""]
        let round6 = picksDictionary["final"] as? String ?? ""
        
        return Picks(round1:round1, round2: round2, round3:round3, round4:round4, round5:round5, round6:round6)
    }
}