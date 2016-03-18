//
//  TeamProvider.swift
//  NYT Madness 2016
//
//  Created by Adam Shott on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct TeamProvider {
    var teams = [Team]()

    func team(name:String) -> Team? {
        for team in teams where team.name == name {
            return team
        }
        return nil
    }
}