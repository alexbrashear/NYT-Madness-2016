//
//  TeamProvider.swift
//  NYT Madness 2016
//
//  Created by Adam Shott on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

protocol TeamProviderDelegate {
    func teamProviderDidUpdate() -> ()
}

struct TeamProvider {
    var teams = [Team]()
    
    var delegate: TeamProviderDelegate?
    
    init() {
        fetchTeams { (optionalTeams:[Team]?) -> () in
            if let fetchedTeams = optionalTeams {
                self.teams = fetchedTeams
                
                if let realDelegate = self.delegate {
                    realDelegate.teamProviderDidUpdate()
                }
            }
        }
    }
    
    
    func team(name:String) -> Team? {
        for team in teams where team.name == name {
            return team
        }
        return nil
    }
}