//
//  PlayerProvider.swift
//  NYT Madness 2016
//
//  Created by Adam Shott on 3/18/16.
//  Copyright © 2016 NYTimes. All rights reserved.
//

import Foundation

struct PlayerProvider {
    var players = [Player]()

    var playerCount: Int {
        return players.count
    }
    
    func player(row: Int) -> Player? {
        if (row < players.count) {
            return players[row]
        }
        return nil
    }
}