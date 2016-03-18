//
//  TeamParser.swift
//  NYT Madness 2016
//
//  Created by Brashear, Alex on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct TeamParser {
    
    func parseTeams(teamDictionary: [String:Int]) -> [Team] {
        var teams = [Team]()
        for (teamName, seed) in teamDictionary {
            teams.append(Team(name: teamName, seed: seed))
        }
        return teams
    }
}
